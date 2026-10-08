import json,glob,collections,re
def gcount(g):
    if not isinstance(g,dict): return {}
    out={}
    for k in ['LMFDB','Annals','OpenAI']:
        v=g.get(k) or []
        out[k]=len(v) if isinstance(v,list) else (v if isinstance(v,int) else 0)
    return out
def grefs(g):
    s=set()
    if isinstance(g,dict):
        for k in ['LMFDB','Annals','OpenAI']:
            for r in (g.get(k) or []) if isinstance(g.get(k),list) else []: s.add(str(r))
    return s
leaves=[]
def emit(x,camp,family=None):
    name=x.get('name','?')
    fam=family or x.get('family') or x.get('parent') or (name.split('/')[0] if '/' in name else None)
    size=str(x.get('size',''))
    origin=x.get('origin','new')
    try: est=int(x.get('est_prs') or 0)
    except: est=int(re.findall(r'\d+',str(x.get('est_prs')))[0]) if re.findall(r'\d+',str(x.get('est_prs'))) else 0
    leaves.append(dict(campaign=camp,family=fam,name=name,topic=x.get('topic'),size=size,est_prs=est,
        wave=str(x.get('wave','?'))[:1],origin=origin,lane=x.get('lane'),goals=gcount(x.get('goals')),refs=sorted(grefs(x.get('goals'))),scope=x.get('scope','')))
for f in sorted(glob.glob('slate_*.json')):
    camp=f[6:-5]
    for x in json.load(open(f)):
        subs=x.get('subroadmaps') or x.get('sub_roadmaps') or []
        if subs and isinstance(subs,list) and isinstance(subs[0],dict):
            for s in subs: emit(s,camp,family=x['name'])
            continue
        if 'XL family' in str(x.get('size','')) and (x.get('children') or x.get('family_est_prs') is not None or 'umbrella' in str(x.get('note',''))):
            continue  # umbrella index row; members listed separately
        emit(x,camp)
json.dump(leaves,open('roadmap_leaves.json','w'),indent=1,ensure_ascii=False)
if __name__=='__main__':
    by=collections.defaultdict(list)
    for l in leaves: by[l['campaign']].append(l)
    tot=[0,0,0,0]
    print('| campaign | new READMEs | families | est. PRs (new) | wave A/B/C | promotion units | est. PRs (promotion) |')
    for c in ['NT','AG','ALG','TOP','GEO','ANA','FAMP','PRDS','COMB','LTCS']:
        L=by.get(c,[])
        new=[l for l in L if l['origin']=='new']; pro=[l for l in L if l['origin']!='new']
        fams={l['family'] for l in new if l['family']}
        w=collections.Counter(l['wave'] for l in new)
        print(f"| {c} | {len(new)} | {len(fams)} | {sum(l['est_prs'] for l in new):,} | {w['A']}/{w['B']}/{w['C']} | {len(pro)} | {sum(l['est_prs'] for l in pro):,} |")
        tot[0]+=len(new); tot[1]+=len(fams); tot[2]+=sum(l['est_prs'] for l in new); tot[3]+=sum(l['est_prs'] for l in pro)
    print('total', tot)
