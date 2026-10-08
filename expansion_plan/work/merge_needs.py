import json,glob,collections
CAMP={'NT':['math.NT'],'AG':['math.AG'],'ALG':['math.AC','math.RA','math.GR','math.RT','math.QA'],
'TOP':['math.AT','math.GT','math.CT','math.KT','math.GN'],'GEO':['math.DG','math.SG','math.MG'],
'ANA':['math.CA','math.CV','math.AP','math.NA','math.OC'],'FAMP':['math.FA','math.OA','math.SP','math.MP','math-ph'],
'PRDS':['math.PR','math.ST','math.DS'],'COMB':['math.CO','cs.DM'],'LTCS':['math.LO','cs.LO','cs.CC','cs.DS','cs.GT','cs.IT','math.IT']}
inv={a:c for c,l in CAMP.items() for a in l}
rows=[]
for f in sorted(x for x in glob.glob('needs_*.jsonl') if x!='needs_all.jsonl'):
    src=f[6:-6]
    for l in open(f):
        if not l.strip(): continue
        r=json.loads(l); r['file']=src
        a=(r.get('arxiv') or '').strip()
        r['campaign']=inv.get(a,'OTHER')
        r['secondary_campaigns']=sorted({inv.get(x,'OTHER') for x in (r.get('secondary_arxiv') or [])}-{r['campaign']})
        rows.append(r)
with open('needs_all.jsonl','w') as o:
    for r in rows: o.write(json.dumps(r,ensure_ascii=False)+'\n')
c=collections.Counter(r['campaign'] for r in rows)
g=collections.defaultdict(collections.Counter)
for r in rows: g[r['campaign']][r['goal']]+=1
gap=collections.Counter(r['campaign'] for r in rows if r.get('coverage')=='gap')
print(len(rows))
for k,v in c.most_common(): print(k,v,dict(g[k]),'gap',gap[k])
print([ (r['arxiv'],r['file']) for r in rows if r['campaign']=='OTHER'][:20])
