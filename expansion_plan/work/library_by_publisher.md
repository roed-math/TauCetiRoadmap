# Library and purchase materials by publisher

2026-10-09. The 1846 works in `references_master.json` whose access is `library` (1792) or `purchase` (54), grouped by parent publisher in the style of `TauCetiRoadmap/references/PUBLISHERS.md`: parent with imprints in parentheses. Each work's `publisher` and `imprint` fields in `references_master.json` carry the same assignment.

**How the publisher was found**, in this order:

1. **zbMATH record** (194 works were matched before zbMATH stopped): the book or series publisher, or, for a journal article, the serial. For journals the serial name is run through the journal table below, because zbMATH gives a serial's current publisher, not the publisher in the year cited (e.g. Publ. Math. IHÉS is listed under IHÉS, distributed by Springer; Compositio before 2004 was Kluwer).
2. **Venue field**: a named publisher (a reprint publisher wins: "Academic Press, reprinted AMS Chelsea" → AMS), else the series (GTM, Grundlehren, Ergebnisse, LNM, Universitext, Progress in Math. → Springer Nature; CSAM, LMS Lecture Notes / Student Texts, Encyclopedia of Math. Appl. → CUP; GSM, Surveys and Monographs, Colloquium, CBMS, PSPM, Memoirs → AMS; Annals of Math. Studies → PUP; Astérisque, Panoramas et Synthèses → SMF; …).
3. **Journal table** (appendix (e)) for journal articles, with the publisher of the year cited where it changed.

`(?)` marks a mapping I am not sure of. Platforms are the likely MIT access route, not checked against MIT's holdings. Wave A = needed by at least one wave-A roadmap.

## (a) By parent publisher

| Publisher (parent; imprints) | Works | Books | Journal papers | Other | Wave A | Likely MIT access platform |
|---|---:|---:|---:|---:|---:|---|
| Springer Nature (Birkhäuser, Kluwer, Vieweg) | 645 | 336 | 265 | 44 | 313 | SpringerLink |
| American Mathematical Society (AMS) | 227 | 111 | 78 | 38 | 121 | AMS eBooks/journals |
| Elsevier (Academic Press, North-Holland, Gauthier-Villars, Pergamon) | 183 | 31 | 142 | 10 | 100 | ScienceDirect |
| Cambridge University Press | 178 | 137 | 32 | 9 | 112 | Cambridge Core |
| Princeton University Press / Annals of Mathematics (Annals of Mathematics) | 150 | 52 | 97 | 1 | 44 | JSTOR (Annals); JSTOR / De Gruyter (PUP e-books) |
| Wiley | 41 | 21 | 20 | 0 | 27 | Wiley Online |
| Société Mathématique de France (SMF, Séminaire Bourbaki) | 33 | 9 | 17 | 7 | 9 | SMF / Numdam (older volumes) |
| Oxford University Press | 30 | 20 | 8 | 2 | 18 | Oxford Academic |
| Johns Hopkins University Press | 26 | 0 | 25 | 1 | 9 | Project MUSE / JSTOR |
| De Gruyter Brill (Vandenhoeck & Ruprecht) | 21 | 6 | 15 | 0 | 12 | De Gruyter |
| Taylor & Francis (CRC / Chapman & Hall, Pitman / Longman) | 21 | 15 | 4 | 2 | 12 | T&F Online / Taylor & Francis eBooks |
| ACM | 20 | 0 | 20 | 0 | 10 | ACM DL |
| Russian Academy of Sciences journals (RAS) | 19 | 0 | 19 | 0 | 9 | mathnet.ru (originals); IOPscience / AMS (translations) |
| International Press | 19 | 2 | 16 | 1 | 3 | International Press (JDG via Project Euclid) |
| EMS Press | 19 | 7 | 12 | 0 | 5 | EMS Press |
| Duke University Press | 18 | 0 | 18 | 0 | 9 | Project Euclid |
| SIAM | 15 | 3 | 12 | 0 | 9 | SIAM |
| London Mathematical Society (Oxford University Press, Wiley) | 15 | 0 | 15 | 0 | 6 | Wiley Online (LMS backfile) |
| Mathematical Society of Japan (MSJ) | 13 | 3 | 3 | 7 | 4 | Project Euclid |
| Centre Mersenne (open access) | 12 | 0 | 12 | 0 | 1 | Centre Mersenne (open access) |
| Institute of Mathematical Statistics | 10 | 0 | 10 | 0 | 5 | Project Euclid |
| World Scientific | 8 | 5 | 3 | 0 | 4 | World Scientific |
| University of Chicago Press | 7 | 7 | 0 | 0 | 2 | print only / Chicago Scholarship Online |
| MSP | 7 | 0 | 7 | 0 | 3 | MSP |
| National Academy of Sciences | 6 | 0 | 6 | 0 | 3 | PNAS (backfile free) |
| Pearson (Addison-Wesley, Prentice Hall, Benjamin) | 6 | 6 | 0 | 0 | 2 | print only |
| Hermann (Paris) | 6 | 5 | 0 | 1 | 5 | print only |
| Schloss Dagstuhl (LIPIcs) | 5 | 0 | 5 | 0 | 4 | open access (LIPIcs) |
| University of Michigan | 5 | 0 | 5 | 0 | 2 | Project Euclid |
| IEEE (IBM) | 5 | 0 | 4 | 1 | 5 | IEEE Xplore |
| American Physical Society | 5 | 0 | 5 | 0 | 0 | APS journals |
| McGraw-Hill | 3 | 3 | 0 | 0 | 3 | print only |
| Université de Genève | 3 | 0 | 3 | 0 | 2 | e-periodica (older volumes free) |
| Tokyo Institute of Technology | 3 | 0 | 3 | 0 | 1 | Project Euclid |
| AIP Publishing | 3 | 0 | 3 | 0 | 1 | AIP Publishing |
| MIT Press | 3 | 3 | 0 | 0 | 3 | MIT Press Direct |
| Mathematica Scandinavica | 3 | 0 | 3 | 0 | 2 | mscand.dk (open access) |
| Indiana University | 3 | 0 | 3 | 0 | 2 | IUMJ (iumj.org) |
| Polish Academy of Sciences (IMPAN) | 3 | 0 | 3 | 0 | 1 | IMPAN |
| Dover | 2 | 2 | 0 | 0 | 1 | print only |
| Royal Society | 2 | 0 | 2 | 0 | 0 | Royal Society Publishing / JSTOR |
| Hindustan Book Agency / TRIM (Hindustan Book Agency / TIFR) | 2 | 1 | 0 | 1 | 1 | print only (some Springer co-editions) |
| IOP Publishing | 2 | 0 | 2 | 0 | 0 | IOPscience |
| Cengage (Wadsworth, Brooks/Cole) | 2 | 2 | 0 | 0 | 1 | print only |
| University of Tokyo | 2 | 0 | 2 | 0 | 1 | University of Tokyo (open access) |
| Tohoku University | 1 | 0 | 1 | 0 | 0 | Project Euclid |
| Japan Academy | 1 | 0 | 1 | 0 | 1 | Project Euclid |
| Others (20 publishers, see (b)) | 23 | 7 | 16 | 0 | 11 | various |
| Undetermined (see (d)) | 10 | 0 | 0 | 10 | 5 | — |
| **Total** | **1846** | **794** | **917** | **135** | **904** | |

"Other" = chapters in edited volumes, proceedings papers (LNM, PSPM, STOC/FOCS, Séminaire Bourbaki), theses and reports.

## (b) Library works by publisher

Books first (master key, short citation, series/volume, `[n roadmaps · best wave]`), then journal papers grouped by journal, then other items. `(?)` after a citation = work not verified; `(?)` after a publisher or journal = mapping unsure.

### Springer Nature (Birkhäuser, Kluwer, Vieweg) — 626

**Books (317)**

- `BridsonHaefliger1999Metric` Bridson–Haefliger 1999, *Metric Spaces of Non-Positive Curvature* (?) [5·A] — Grundlehren der mathematischen Wissenschaften 319
- `Hartshorne1977Algebraic` Hartshorne 1977, *Algebraic Geometry* [5·A] — Graduate Texts in Math. 52
- `Petersen2016Riemannian` Petersen 2016, *Riemannian Geometry* (?) [5·A] — Graduate Texts in Mathematics 171
- `BoschLutkebohmertRaynaud1990Neron` Bosch–Lütkebohmert–Raynaud 1990, *Néron Models* [4·A] — Ergebnisse der Math. (3) 21
- `BratteliRobinson1997Operator` Bratteli–Robinson 1997, *Operator Algebras and Quantum Statistical Mechanics 2* (?) [4·A] — Texts and Monographs in Physics
- `EinsiedlerWard2011Ergodic` Einsiedler–Ward 2011, *Ergodic Theory with a view towards Number Theory* (?) [4·A] — Graduate Texts in Mathematics 259
- `FaltingsChai1990Degeneration` Faltings–Chai 1990, *Degeneration of Abelian Varieties* [4·A] — Ergebnisse der Mathematik (3) 22
- `Huber1996Etale` Huber 1996, *Étale Cohomology of Rigid Analytic Varieties and Adic Spaces* [4·A] — Aspects of Mathematics E30, Vieweg
- `KashiwaraSchapira1990Sheaves` Kashiwara–Schapira 1990, *Sheaves on Manifolds* (?) [4·A] — Grundlehren der mathematischen Wissenschaften 292
- `Lazarsfeld2004PositivityII` Lazarsfeld 2004, *Positivity in Algebraic Geometry II* (?) [4·A] — Ergebnisse der Math. (3) 49
- `Lee2018Riemannian` Lee 2018, *Riemannian Manifolds* (?) [4·A] — Graduate Texts in Mathematics 176
- `Schrijver2003Combinatorial` Schrijver 2003, *Combinatorial Optimization* (?) [4·A] — Algorithms and Combinatorics 24
- `AlbiacKalton2016Topics` Albiac–Kalton 2016, *Banach Space Theory* (?) [3·A] — Graduate Texts in Mathematics 233
- `DiamondShurman2005First` Diamond–Shurman 2005, *Modular Forms* [3·A] — Graduate Texts in Mathematics 228
- `Dimca2004Sheaves` Dimca 2004, *Sheaves in Topology* (?) [3·A] — Universitext
- `Eisenbud1995Commutative` Eisenbud 1995, *Commutative Algebra with a View Toward Algebraic Geometry* (?) [3·A] — Graduate Texts in Mathematics 150
- `ElstrodtGrunewaldMennicke1998Groups` Elstrodt–Grunewald–Mennicke 1998, *Groups Acting on Hyperbolic Space* [3·A] — Monographs in Mathematics
- `Federer1969Geometric` Federer 1969, *Geometric Measure Theory* (?) [3·A] — Grundlehren der mathematischen Wissenschaften 153
- `Forster1981Lectures` Forster 1981, *Riemann Surfaces* [3·A] — Graduate Texts in Mathematics 81
- `FriedlanderGrayson2005Handbook` Friedlander–Grayson 2005, *Handbook of K-Theory* [3·A] — —
- `GilbargTrudinger2001Elliptic` Gilbarg–Trudinger 2001, *Elliptic Partial Differential Equations of Second Order* (?) [3·A] — Classics in Mathematics (reprint of the 1983 2nd ed.)
- `Grafakos2014Classical` Grafakos 2014, *Classical Fourier Analysis* (?) [3·A] — Graduate Texts in Mathematics 249
- `Grafakos2014Modern` Grafakos 2014, *Modern Fourier Analysis* (?) [3·A] — Graduate Texts in Mathematics 250
- `HottaTakeuchiTanisaki2008D` Hotta–Takeuchi–Tanisaki 2008, *D-Modules, Perverse Sheaves, and Representation Theory* (?) [3·A] — Progress in Mathematics 236
- `Huybrechts2005Complex` Huybrechts 2005, *Complex Geometry* (?) [3·A] — Universitext
- `Lazarsfeld2004Positivity` Lazarsfeld 2004, *Positivity in Algebraic Geometry I* (?) [3·A] — Ergebnisse der Math. (3) 48
- `Matousek2002Lectures` Matoušek 2002, *Discrete Geometry* (?) [3·A] — Graduate Texts in Mathematics 212
- `McDuffSalamon2017Symplectic` McDuff–Salamon 2017, *Symplectic Topology* [3·A] — Oxford Graduate Texts in Mathematics 27
- `MumfordFogartyKirwan1994Geometric` Mumford–Fogarty–Kirwan 1994, *Geometric Invariant Theory* [3·A] — Ergebnisse der Math. (2) 34
- `Neukirch1999Algebraic` Neukirch 1999, *Algebraic Number Theory* [3·A] — Grundlehren der mathematischen Wissenschaften 322
- `Stichtenoth2009Algebraic` Stichtenoth 2009, *Algebraic Function Fields and Codes* [3·A] — Graduate Texts in Mathematics 254
- `Walters1982Ergodic` Walters 1982, *Ergodic Theory* (?) [3·A] — Graduate Texts in Mathematics 79
- `Washington1997Cyclotomic` Washington 1997, *Cyclotomic Fields* [3·A] — Graduate Texts in Mathematics 83
- `Weil1982Adeles` Weil 1982, *Adeles and Algebraic Groups* [3·A] — Progress in Mathematics 23
- `BerthelotGrothendieckIllusie1971Theorie` Berthelot et al. 1971, *Théorie des intersections et théorème de Riemann–Roch (SGA…* (?) [2·A] — Lecture Notes in Math. 225
- `Bhatia1997Matrix` Bhatia 1997, *Matrix Analysis* (?) [2·A] — Graduate Texts in Mathematics 169
- `BirkenhakeLange2004Complex` Birkenhake–Lange 2004, *Complex Abelian Varieties* (?) [2·A] — Grundlehren 302
- `BondyMurty2008Graph` Bondy–Murty 2008, *Graph Theory* (?) [2·A] — Graduate Texts in Mathematics 244
- `BrionKumar2005Frobenius` Brion–Kumar 2005, *Frobenius Splitting Methods in Geometry and Representation…* (?) [2·A] — Progress in Mathematics 231
- `ChrissGinzburg1997Representation` Chriss–Ginzburg 1997, *Representation Theory and Complex Geometry* (?) [2·A] — (Modern Classics reprint 2010)
- `Cohen1993Course` Cohen 1993, *Computational Algebraic Number Theory* [2·A] — Graduate Texts in Mathematics 138
- `Conway1995Functions` Conway 1995, *Functions of One Complex Variable II* (?) [2·A] — Graduate Texts in Mathematics 159
- `Davenport2000Multiplicative` Davenport 2000, *Multiplicative Number Theory* [2·A] — Graduate Texts in Mathematics 74
- `Debarre2001Higher` Debarre 2001, *Higher-Dimensional Algebraic Geometry* (?) [2·A] — Universitext
- `DeligneEtAl1982Hodge` Deligne et al. 1982, *Hodge Cycles, Motives, and Shimura Varieties* (?) [2·A] — Lecture Notes in Math. 900
- `DezaLaurent1997Geometry` Deza–Laurent 1997, *Geometry of Cuts and Metrics* (?) [2·A] — Algorithms and Combinatorics 15
- `EichlerZagier1985Theory` Eichler–Zagier 1985, *Theory of Jacobi Forms* [2·A] — Progress in Mathematics 55
- `FabianEtAl2011Banach` Fabian et al. 2011, *Banach Space Theory* (?) [2·A] — CMS Books in Mathematics
- `Geoghegan2008Topological` Geoghegan 2008, *Topological Methods in Group Theory* (?) [2·A] — Graduate Texts in Mathematics 243
- `GhysHarpe1990Groupes` Ghys–de la Harpe 1990, *Sur les groupes hyperboliques d'après Mikhael Gromov* (?) [2·A] — Progress in Mathematics 83
- `Heinonen2001Lectures` Heinonen 2001, *Analysis on Metric Spaces* (?) [2·A] — Universitext
- `IrelandRosen1990Classical` Ireland–Rosen 1990, *Classical Introduction to Modern Number Theory* [2·A] — Graduate Texts in Mathematics 84
- `Joyce2007Riemannian` Joyce 2007, *Riemannian Holonomy Groups and Calibrated Geometry* (?) [2·A] — Oxford Graduate Texts in Mathematics 12
- `KaratzasShreve1991Brownian` Karatzas–Shreve 1991, *Brownian Motion and Stochastic Calculus* (?) [2·A] — Graduate Texts in Mathematics 113
- `KempfEtAl1973Toroidal` Kempf et al. 1973, *Toroidal Embeddings I* (?) [2·A] — Lecture Notes in Math. 339
- `KerrLi2016Ergodic` Kerr–Li 2016, *Ergodic Theory* (?) [2·A] — Monographs in Mathematics
- `LaumonMoretBailly2000Champs` Laumon–Moret-Bailly 2000, *Champs algébriques* [2·A] — Ergebnisse der Math. (3) 39
- `LindenstraussTzafriri1977Classical` Lindenstrauss–Tzafriri 1977, *Classical Banach Spaces I* (?) [2·A] — Ergebnisse der Mathematik und ihrer Grenzgebiete 92
- `Lubotzky1994Discrete` Lubotzky 1994, *Discrete Groups, Expanding Graphs and Invariant Measures* (?) [2·A] — Progress in Mathematics 125
- `Luck2002L2` Lück 2002, *L²-Invariants* (?) [2·A] — Ergebnisse der Mathematik und ihrer Grenzgebiete (3) 44
- `Matousek2003Using` Matoušek 2003, *Using the Borsuk–Ulam Theorem* (?) [2·A] — Universitext
- `MilnorHusemoller1973Symmetric` Milnor–Husemoller 1973, *Symmetric Bilinear Forms* [2·A] — Ergebnisse der Mathematik 73
- `PetersSteenbrink2008Mixed` Peters–Steenbrink 2008, *Mixed Hodge Structures* (?) [2·A] — Ergebnisse der Math. (3) 52
- `Raghunathan1972Discrete` Raghunathan 1972, *Discrete Subgroups of Lie Groups* (?) [2·A] — Ergebnisse der Mathematik und ihrer Grenzgebiete 68
- `RevuzYor1999Continuous` Revuz–Yor 1999, *Continuous Martingales and Brownian Motion* (?) [2·A] — Grundlehren der mathematischen Wissenschaften 293
- `Rosen2002Number` Rosen 2002, *Number Theory in Function Fields* [2·A] — Graduate Texts in Mathematics 210
- `Serre2000Local` Serre 2000, *Local Algebra* (?) [2·A] — Monographs in Mathematics (transl. of Algèbre locale, multiplicités, LNM 11)
- `Takesaki2002Theory` Takesaki 2002, *Theory of Operator Algebras I* (?) [2·A] — Encyclopaedia of Mathematical Sciences 124 (Operator Algebras and Non-commutative Geometry 5)
- `Takesaki2003Theory` Takesaki 2003, *Theory of Operator Algebras II* (?) [2·A] — Encyclopaedia of Mathematical Sciences 125 (Operator Algebras and Non-commutative Geometry 6)
- `Taylor2011Partial` Taylor 2011, *Partial Differential Equations I* (?) [2·A] — Applied Mathematical Sciences 115
- `Villani2009Optimal` Villani 2009, *Optimal Transport* (?) [2·A] — Grundlehren der mathematischen Wissenschaften 338
- `Warner1983Foundations` Warner 1983, *Foundations of Differentiable Manifolds and Lie Groups* (?) [2·A] — Graduate Texts in Mathematics 94
- `Weil1974Basic` Weil 1974, *Basic Number Theory* [2·A] — Grundlehren der mathematischen Wissenschaften 144
- `AbramenkoBrown2008Buildings` Abramenko–Brown 2008, *Buildings* (?) [1·A] — Graduate Texts in Mathematics 248
- `ArbarelloEtAl1985Geometry` Arbarello et al. 1985, *Geometry of Algebraic Curves I* (?) [1·A] — Grundlehren 267
- `Asmussen2003Applied` Asmussen 2003, *Applied Probability and Queues* (?) [1·A] — Applications of Mathematics 51
- `Aubin1998Nonlinear` Aubin 1998, *Some Nonlinear Problems in Riemannian Geometry* (?) [1·A] — Monographs in Mathematics
- `BahouriCheminDanchin2011Fourier` Bahouri–Chemin–Danchin 2011, *Fourier Analysis and Nonlinear Partial Differential…* (?) [1·A] — Grundlehren der mathematischen Wissenschaften 343
- `BainCrisan2009Fundamentals` Bain–Crisan 2009, *Fundamentals of Stochastic Filtering* (?) [1·A] — Stochastic Modelling and Applied Probability 60
- `BakryGentilLedoux2014Analysis` Bakry–Gentil–Ledoux 2014, *Analysis and Geometry of Markov Diffusion Operators* (?) [1·A] — Grundlehren der mathematischen Wissenschaften 348
- `BerghLofstrom1976Interpolation` Bergh–Löfström 1976, *Interpolation Spaces* (?) [1·A] — Grundlehren der mathematischen Wissenschaften 223
- `Bergman2015Invitation` Bergman 2015, *Invitation to General Algebra and Universal Constructions* (?) [1·A] — Universitext
- `Berthelot1974Cohomologie` Berthelot 1974, *Cohomologie cristalline des schémas de caractéristique p > 0* (?) [1·A] — Lecture Notes in Math. 407
- `Besse1987Einstein` Besse 1987, *Einstein Manifolds* (?) [1·A] — Ergebnisse der Mathematik und ihrer Grenzgebiete (3) 10
- `BjornerBrenti2005Combinatorics` Björner–Brenti 2005, *Combinatorics of Coxeter Groups* (?) [1·A] — Graduate Texts in Mathematics 231
- `Blackadar2006Operator` Blackadar 2006, *Operator Algebras* (?) [1·A] — Encyclopaedia of Mathematical Sciences 122 (Operator Algebras and Non-commutative Geometry 3)
- `Bosch2014Lectures` Bosch 2014, *Formal and Rigid Geometry* (?) [1·A] — Lecture Notes in Math. 2105
- `BottTu1982Differential` Bott–Tu 1982, *Differential Forms in Algebraic Topology* (?) [1·A] — Graduate Texts in Mathematics 82
- `BousfieldKan1972Homotopy` Bousfield–Kan 1972, *Homotopy Limits, Completions and Localizations* (?) [1·A] — Lecture Notes in Mathematics 304
- `BratteliRobinson1987Operator` Bratteli–Robinson 1987, *Operator Algebras and Quantum Statistical Mechanics 1* (?) [1·A] — Texts and Monographs in Physics
- `Bump2013Lie` Bump 2013, *Lie Groups* [1·A] — Graduate Texts in Mathematics 225
- `Carr1981Applications` Carr 1981, *Applications of Centre Manifold Theory* (?) [1·A] — Applied Mathematical Sciences 35
- `Cazenave2003Semilinear` Cazenave 2003, *Semilinear Schrödinger Equations* (?) [1·A] — Courant Lecture Notes in Mathematics 10
- `CeccheriniSilbersteinCoornaert2010Cellular` Ceccherini-Silberstein–Coornaert 2010, *Cellular Automata and Groups* (?) [1·A] — Monographs in Mathematics
- `Chicone2006Ordinary` Chicone 2006, *Ordinary Differential Equations with Applications* (?) [1·A] — Texts in Applied Mathematics 34
- `ClementMajewiczZyman2017Theory` Clement–Majewicz–Zyman 2017, *Theory of Nilpotent Groups* (?) [1·A] — —
- `Conrad2000Grothendieck` Conrad 2000, *Grothendieck Duality and Base Change* (?) [1·A] — Lecture Notes in Math. 1750
- `Conway1978Functions` Conway 1978, *Functions of One Complex Variable I* (?) [1·A] — Graduate Texts in Mathematics 11
- `Conway1990Course` Conway 1990, *Functional Analysis* (?) [1·A] — Graduate Texts in Mathematics 96
- `Dacorogna2008Direct` Dacorogna 2008, *Direct Methods in the Calculus of Variations* (?) [1·A] — Applied Mathematical Sciences 78
- `Dafermos2016Hyperbolic` Dafermos 2016, *Hyperbolic Conservation Laws in Continuum Physics* (?) [1·A] — Grundlehren der mathematischen Wissenschaften 325
- `DemboZeitouni1998Large` Dembo–Zeitouni 1998, *Large Deviations Techniques and Applications* (?) [1·A] — Stochastic Modelling and Applied Probability 38 (corrected printing 2010)
- `Diestel1984Sequences` Diestel 1984, *Sequences and Series in Banach Spaces* (?) [1·A] — Graduate Texts in Mathematics 92
- `DixonMortimer1996Permutation` Dixon–Mortimer 1996, *Permutation Groups* (?) [1·A] — Graduate Texts in Mathematics 163
- `DoCarmo1992Riemannian` do Carmo 1992, *Riemannian Geometry* (?) [1·A] — Mathematics: Theory & Applications
- `DrenskyFormanek2004Polynomial` Drensky–Formanek 2004, *Polynomial Identity Rings* (?) [1·A] — Advanced Courses in Mathematics CRM Barcelona
- `Duren1983Univalent` Duren 1983, *Univalent Functions* (?) [1·A] — Grundlehren der mathematischen Wissenschaften 259
- `Eisenbud2005Geometry` Eisenbud 2005, *Geometry of Syzygies* (?) [1·A] — Graduate Texts in Mathematics 229
- `EnglerPrestel2005Valued` Engler–Prestel 2005, *Valued Fields* [1·A] — Monographs in Mathematics
- `Essen2000Polynomial` van den Essen 2000, *Polynomial Automorphisms and the Jacobian Conjecture* (?) [1·A] — Progress in Mathematics 190
- `Feinberg2019Foundations` Feinberg 2019, *Foundations of Chemical Reaction Network Theory* (?) [1·A] — Applied Mathematical Sciences 202
- `FelixHalperinThomas2001Rational` Félix–Halperin–Thomas 2001, *Rational Homotopy Theory* (?) [1·A] — Graduate Texts in Mathematics 205
- `Freudenburg2017Algebraic` Freudenburg 2017, *Algebraic Theory of Locally Nilpotent Derivations* (?) [1·A] — Encyclopaedia of Mathematical Sciences 136
- `Frohlich1983Galois` Fröhlich 1983, *Galois Module Structure of Algebraic Integers* [1·A] — Ergebnisse der Mathematik (3) 1
- `Fulton1998Intersection` Fulton 1998, *Intersection Theory* (?) [1·A] — Ergebnisse der Math. (3) 2
- `Gall2016Brownian` Le Gall 2016, *Brownian Motion, Martingales, and Stochastic Calculus* (?) [1·A] — Graduate Texts in Mathematics 274
- `Garnett2007Bounded` Garnett 2007, *Bounded Analytic Functions* (?) [1·A] — Graduate Texts in Mathematics 236
- `Gelbart1976Weil` Gelbart 1976, *Weil's Representation and the Spectrum of the Metaplectic…* [1·A] — Lecture Notes in Mathematics 530
- `GodsilRoyle2001Algebraic` Godsil–Royle 2001, *Algebraic Graph Theory* (?) [1·A] — Graduate Texts in Mathematics 207
- `GoerssJardine2009Simplicial` Goerss–Jardine 2009, *Simplicial Homotopy Theory* [1·A] — Modern Classics (reprint of Progress in Mathematics 174, 1999)
- `GrauertRemmert1979Theory` Grauert–Remmert 1979, *Theory of Stein Spaces* (?) [1·A] — Grundlehren der mathematischen Wissenschaften 236
- `Grimmett1999Percolation` Grimmett 1999, *Percolation* (?) [1·A] — Grundlehren der mathematischen Wissenschaften 321
- `GuckenheimerHolmes1983Nonlinear` Guckenheimer–Holmes 1983, *Nonlinear Oscillations, Dynamical Systems, and Bifurcations…* (?) [1·A] — Applied Mathematical Sciences 42
- `HajekPudlak1993Metamathematics` Hájek–Pudlák 1993, *Metamathematics of First-Order Arithmetic* (?) [1·A] — Perspectives in Mathematical Logic
- `Hall2013Quantum` Hall 2013, *Quantum Theory for Mathematicians* (?) [1·A] — Graduate Texts in Mathematics 267
- `Hartshorne1966Residues` Hartshorne 1966, *Residues and Duality* (?) [1·A] — Lecture Notes in Math. 20
- `Hejhal1983Selberg` Hejhal 1983, *Selberg Trace Formula for PSL(2,R), Volume 2* (?) [1·A] — Lecture Notes in Mathematics 1001
- `HerzogHibi2011Monomial` Herzog–Hibi 2011, *Monomial Ideals* (?) [1·A] — Graduate Texts in Mathematics 260
- `HiaiPetz2014Matrix` Hiai–Petz 2014, *Matrix Analysis and Applications* (?) [1·A] — Universitext
- `Hormander1997Lectures` Hörmander 1997, *Nonlinear Hyperbolic Differential Equations* (?) [1·A] — Mathématiques & Applications 26
- `Huppert1967Endliche` Huppert 1967, *Endliche Gruppen I* (?) [1·A] — Grundlehren der mathematischen Wissenschaften 134
- `IwasakiEtAl1991Gauss` Iwasaki et al. 1991, *From Gauss to Painlevé* (?) [1·A] — Aspects of Mathematics E16, Vieweg
- `Jukna2011Extremal` Jukna 2011, *Extremal Combinatorics* (?) [1·A] — Texts in Theoretical Computer Science
- `Kallenberg2021Foundations` Kallenberg 2021, *Foundations of Modern Probability* (?) [1·A] — Probability Theory and Stochastic Modelling
- `Knus1991Quadratic` Knus 1991, *Quadratic and Hermitian Forms over Rings* (?) [1·A] — Grundlehren der mathematischen Wissenschaften 294
- `Knutson1971Algebraic` Knutson 1971, *Algebraic Spaces* [1·A] — Lecture Notes in Math. 203
- `Koblitz1993Elliptic` Koblitz 1993, *Elliptic Curves and Modular Forms* [1·A] — Graduate Texts in Mathematics 97
- `Kozlov2008Combinatorial` Kozlov 2008, *Combinatorial Algebraic Topology* (?) [1·A] — Algorithms and Computation in Mathematics 21
- `KurzweilStellmacher2004Theory` Kurzweil–Stellmacher 2004, *Theory of Finite Groups* (?) [1·A] — Universitext
- `Kuznetsov2004Elements` Kuznetsov 2004, *Applied Bifurcation Theory* (?) [1·A] — Applied Mathematical Sciences 112
- `Lam2001First` Lam 2001, *Noncommutative Rings* (?) [1·A] — Graduate Texts in Mathematics 131
- `LandoZvonkin2004Graphs` Lando–Zvonkin 2004, *Graphs on Surfaces and Their Applications* (?) [1·A] — Encyclopaedia of Mathematical Sciences 141
- `Lang1990Cyclotomic` Lang 1990, *Cyclotomic Fields I and II (with an appendix by K. Rubin)* [1·A] — Graduate Texts in Mathematics 121
- `LedouxTalagrand1991Probability` Ledoux–Talagrand 1991, *Probability in Banach Spaces* (?) [1·A] — Ergebnisse der Mathematik und ihrer Grenzgebiete (3) 23
- `LehtoVirtanen1973Quasiconformal` Lehto–Virtanen 1973, *Quasiconformal Mappings in the Plane* (?) [1·A] — Grundlehren der mathematischen Wissenschaften 126
- `Lemmermeyer2000Reciprocity` Lemmermeyer 2000, *Reciprocity Laws* [1·A] — Monographs in Mathematics
- `Lickorish1997Knot` Lickorish 1997, *Knot Theory* (?) [1·A] — Graduate Texts in Mathematics 175
- `LinaresPonce2015Nonlinear` Linares–Ponce 2015, *Nonlinear Dispersive Equations* (?) [1·A] — Universitext
- `LindenstraussTzafriri1979Classical` Lindenstrauss–Tzafriri 1979, *Classical Banach Spaces II* (?) [1·A] — Ergebnisse der Mathematik und ihrer Grenzgebiete 97
- `LyndonSchupp1977Combinatorial` Lyndon–Schupp 1977, *Combinatorial Group Theory* (?) [1·A] — Ergebnisse der Mathematik und ihrer Grenzgebiete 89 (Classics in Mathematics reprint 2001)
- `MadrasSlade1993Self` Madras–Slade 1993, *Self-Avoiding Walk* (?) [1·A] — Probability and Its Applications
- `Majda1984Compressible` Majda 1984, *Compressible Fluid Flow and Systems of Conservation Laws in…* (?) [1·A] — Applied Mathematical Sciences 53
- `Miyake1989Modular` Miyake 1989, *Modular Forms* [1·A] — ( Monographs in Mathematics reprint 2006)
- `MolloyReed2002Graph` Molloy–Reed 2002, *Graph Colouring and the Probabilistic Method* (?) [1·A] — Algorithms and Combinatorics 23
- `Oda1988Convex` Oda 1988, *Convex Bodies and Algebraic Geometry* (?) [1·A] — Ergebnisse der Math. (3) 15
- `OlShanskii1991Geometry` Ol'shanskii 1991, *Geometry of Defining Relations in Groups* (?) [1·A] — Mathematics and its Applications (Soviet Series) 70, Kluwer
- `Oxley2011Matroid` Oxley 2011, *Matroid Theory* (?) [1·A] — Oxford Graduate Texts in Mathematics 21
- `OzbagciStipsicz2004Surgery` Ozbagci–Stipsicz 2004, *Surgery on Contact 3-Manifolds and Stein Surfaces* (?) [1·A] — Bolyai Society Mathematical Studies 13
- `Peeva2011Graded` Peeva 2011, *Graded Syzygies* (?) [1·A] — Algebra and Applications 14
- `Perko2001Differential` Perko 2001, *Differential Equations and Dynamical Systems* (?) [1·A] — Texts in Applied Mathematics 7
- `Pisier2001Similarity` Pisier 2001, *Similarity Problems and Completely Bounded Maps* (?) [1·A] — Lecture Notes in Mathematics 1618
- `PolyaRead1987Combinatorial` Pólya–Read 1987, *Combinatorial Enumeration of Groups, Graphs, and Chemical…* (?) [1·A] — —
- `Pommerenke1992Boundary` Pommerenke 1992, *Boundary Behaviour of Conformal Maps* (?) [1·A] — Grundlehren der mathematischen Wissenschaften 299
- `Quillen1967Homotopical` Quillen 1967, *Homotopical Algebra* (?) [1·A] — Lecture Notes in Mathematics 43
- `RadjaviRosenthal1973Invariant` Radjavi–Rosenthal 1973, *Invariant Subspaces* (?) [1·A] — Ergebnisse der Mathematik und ihrer Grenzgebiete 77; 2nd ed. Dover (2003)
- `RamakrishnanValenza1999Fourier` Ramakrishnan–Valenza 1999, *Fourier Analysis on Number Fields* [1·A] — Graduate Texts in Mathematics 186
- `RibesZalesskii2010Profinite` Ribes–Zalesskii 2010, *Profinite Groups* [1·A] — Ergebnisse der Mathematik und ihrer Grenzgebiete (3) 40
- `Rosenberg1994Algebraic` Rosenberg 1994, *Algebraic K-Theory and Its Applications* (?) [1·A] — Graduate Texts in Mathematics 147
- `Rotman1995Theory` Rotman 1995, *Theory of Groups* (?) [1·A] — Graduate Texts in Mathematics 148
- `Roussarie1998Bifurcations` Roussarie 1998, *Bifurcations of Planar Vector Fields and Hilbert's…* (?) [1·A] — Progress in Mathematics 164
- `Sakai1971C` Sakai 1971, *C*-Algebras and W*-Algebras* (?) [1·A] — Ergebnisse der Mathematik und ihrer Grenzgebiete 60
- `Schwarz1995Hodge` Schwarz 1995, *Hodge Decomposition — A Method for Solving Boundary Value…* (?) [1·A] — Lecture Notes in Mathematics 1607
- `Sernesi2006Deformations` Sernesi 2006, *Deformations of Algebraic Schemes* [1·A] — Grundlehren 334
- `Serre1980Trees` Serre 1980, *Trees* (?) [1·A] — (transl. of Arbres, amalgames, SL2, Astérisque 46, 1977)
- `Silverman1994Advanced` Silverman 1994, *Advanced Topics in the Arithmetic of Elliptic Curves* [1·A] — Graduate Texts in Mathematics 151
- `Simon2019Loewner` Simon 2019, *Loewner's Theorem on Monotone Matrix Functions* (?) [1·A] — Grundlehren der mathematischen Wissenschaften 354
- `Springer1977Invariant` Springer 1977, *Invariant Theory* (?) [1·A] — Lecture Notes in Mathematics 585
- `Srinivas1996Algebraic` Srinivas 1996, *Algebraic K-Theory* (?) [1·A] — Progress in Mathematics 90
- `StroockVaradhan1979Multidimensional` Stroock–Varadhan 1979, *Multidimensional Diffusion Processes* (?) [1·A] — Grundlehren der mathematischen Wissenschaften 233
- `Struwe2008Variational` Struwe 2008, *Variational Methods* (?) [1·A] — Ergebnisse der Mathematik und ihrer Grenzgebiete (3) 34
- `SzNagyEtAl2010Harmonic` Sz.-Nagy et al. 2010, *Harmonic Analysis of Operators on Hilbert Space* (?) [1·A] — Universitext
- `Tachikawa1973Quasi` Tachikawa 1973, *Quasi-Frobenius Rings and Generalizations* (?) [1·A] — Lecture Notes in Mathematics 351
- `Takesaki2003TheoryIII` Takesaki 2003, *Theory of Operator Algebras III* (?) [1·A] — Encyclopaedia of Mathematical Sciences 127 (Operator Algebras and Non-commutative Geometry 8)
- `Talagrand2021Upper` Talagrand 2021, *Upper and Lower Bounds for Stochastic Processes* (?) [1·A] — Ergebnisse der Mathematik und ihrer Grenzgebiete (3)
- `Taylor2011PartialIII` Taylor 2011, *Partial Differential Equations I–III* (?) [1·A] — Applied Mathematical Sciences 115–117
- `Triebel1983Theory` Triebel 1983, *Theory of Function Spaces* (?) [1·A] — Monographs in Mathematics 78
- `Tu2017Differential` Tu 2017, *Differential Geometry* (?) [1·A] — Graduate Texts in Mathematics 275
- `Vigneras1980Arithmetique` Vignéras 1980, *Arithmétique des Algèbres de Quaternions* [1·A] — Lecture Notes in Mathematics 800
- `Vigneras1996Representations` Vignéras 1996, *Représentations l-modulaires d'un groupe réductif p-adique…* (?) [1·A] — Progress in Mathematics 137
- `Wehrfritz1973Infinite` Wehrfritz 1973, *Infinite Linear Groups* (?) [1·A] — Ergebnisse der Mathematik und ihrer Grenzgebiete 76
- `Whitehead1978Elements` Whitehead 1978, *Homotopy Theory* (?) [1·A] — Graduate Texts in Mathematics 61
- `Yamada1974Schur` Yamada 1974, *Schur Subgroup of the Brauer Group* (?) [1·A] — Lecture Notes in Mathematics 397
- `Ziegler1995Lectures` Ziegler 1995, *Polytopes* (?) [1·A] — Graduate Texts in Mathematics 152
- `Deligne1977Cohomologie` Deligne 1977, *Cohomologie étale (SGA 4½)* (?) [4·B] — Lecture Notes in Math. 569
- `ConwaySloane1999Sphere` Conway–Sloane 1999, *Sphere Packings, Lattices and Groups* [3·B] — Grundlehren der mathematischen Wissenschaften 290
- `DeligneKatz1973Groupes` Deligne–Katz 1973, *Groupes de monodromie en géométrie algébrique (SGA 7 II)* [3·B] — Lecture Notes in Math. 340
- `Arnold1989Mathematical` Arnold 1989, *Mathematical Methods of Classical Mechanics* (?) [2·B] — Graduate Texts in Mathematics 60
- `ArtinGrothendieckVerdier1972Theorie` Artin–Grothendieck–Verdier 1972, *Théorie des topos et cohomologie étale des schémas (SGA 4)* (?) [2·B] — Lecture Notes in Math. 269, 270, 305
- `BarthEtAl2004Compact` Barth et al. 2004, *Compact Complex Surfaces* (?) [2·B] — Ergebnisse der Math. (3) 4
- `Bredon1997Sheaf` Bredon 1997, *Sheaf Theory* (?) [2·B] — Graduate Texts in Mathematics 170
- `Brown1982Cohomology` Brown 1982, *Cohomology of Groups* [2·B] — Graduate Texts in Mathematics 87
- `BushnellHenniart2006Local` Bushnell–Henniart 2006, *Local Langlands Conjecture for GL(2)* (?) [2·B] — Grundlehren der mathematischen Wissenschaften 335
- `Giusti1984Minimal` Giusti 1984, *Minimal Surfaces and Functions of Bounded Variation* (?) [2·B] — Monographs in Mathematics 80
- `MingoSpeicher2017Free` Mingo–Speicher 2017, *Free Probability and Random Matrices* (?) [2·B] — Fields Institute Monographs 35
- `Schmudgen2012Unbounded` Schmüdgen 2012, *Unbounded Self-adjoint Operators on Hilbert Space* (?) [2·B] — Graduate Texts in Mathematics 265
- `Ueno1975Classification` Ueno 1975, *Classification Theory of Algebraic Varieties and Compact…* (?) [2·B] — Lecture Notes in Math. 439
- `ArbarelloCornalbaGriffiths2011Geometry` Arbarello–Cornalba–Griffiths 2011, *Geometry of Algebraic Curves II* (?) [1·B] — Grundlehren 268
- `ArnoldGuseinZadeVarchenko1985Singularities` Arnold–Gusein-Zade–Varchenko 1985, *Singularities of Differentiable Maps I, II* (?) [1·B] — Monographs in Math. 82, 83
- `Audin2004Torus` Audin 2004, *Torus Actions on Symplectic Manifolds* (?) [1·B] — Progress in Mathematics 93
- `AudinLafontaine1994Holomorphic` Audin–Lafontaine 1994, *Holomorphic Curves in Symplectic Geometry* (?) [1·B] — Progress in Mathematics 117
- `Badescu2001Algebraic` Bădescu 2001, *Algebraic Surfaces* (?) [1·B] — Universitext
- `BangJensenGutin2009Digraphs` Bang-Jensen–Gutin 2009, *Digraphs: Theory, Algorithms and Applications* [1·B] — Monographs in Mathematics
- `BenedettiPetronio1992Lectures` Benedetti–Petronio 1992, *Hyperbolic Geometry* (?) [1·B] — Universitext
- `BergerGauduchonMazet1971Spectre` Berger–Gauduchon–Mazet 1971, *Le spectre d'une variété riemannienne* (?) [1·B] — Lecture Notes in Mathematics 194
- `BerlineGetzlerVergne1992Heat` Berline–Getzler–Vergne 1992, *Heat Kernels and Dirac Operators* (?) [1·B] — Grundlehren der mathematischen Wissenschaften 298
- `Besse1978Manifolds` Besse 1978, *Manifolds All of Whose Geodesics Are Closed* (?) [1·B] — Ergebnisse der Mathematik und ihrer Grenzgebiete 93
- `BoardmanVogt1973Homotopy` Boardman–Vogt 1973, *Homotopy Invariant Algebraic Structures on Topological…* (?) [1·B] — Lecture Notes in Mathematics 347
- `Bonnafe2011Representations` Bonnafé 2011, *Representations of SL2(F_q)* (?) [1·B] — Algebra and Applications 13
- `BorodachovHardinSaff2019Discrete` Borodachov–Hardin–Saff 2019, *Discrete Energy on Rectifiable Sets* (?) [1·B] — Monographs in Mathematics
- `Bowen1975Equilibrium` Bowen 1975, *Equilibrium States and the Ergodic Theory of Anosov…* (?) [1·B] — Lecture Notes in Math. 470 (2nd revised ed. 2008)
- `Buser1992Geometry` Buser 1992, *Geometry and Spectra of Compact Riemann Surfaces* (?) [1·B] — Progress in Mathematics 106
- `CyconEtAl1987Schrodinger` Cycon et al. 1987, *Schrödinger Operators with Application to Quantum Mechanics…* (?) [1·B] — Texts and Monographs in Physics
- `CyganEtAl2015Parameterized` Cygan et al. 2015, *Parameterized Algorithms* (?) [1·B] — —
- `EngelNagel2000One` Engel–Nagel 2000, *One-Parameter Semigroups for Linear Evolution Equations* (?) [1·B] — Graduate Texts in Mathematics 194
- `EsnaultViehweg1992Lectures` Esnault–Viehweg 1992, *Vanishing Theorems* (?) [1·B] — DMV Seminar 20
- `Evans2008Probability` Evans 2008, *Probability and Real Trees* (?) [1·B] — École d'Été de Probabilités de Saint-Flour XXXV (2005), Lecture Notes in Math. 1920
- `FejesTothGFejesTothKuperbergEds2023Lagerungen` Fejes Tóth (G. Fejes Tóth et al. 2023, *Lagerungen* (?) [1·B] — Grundlehren der mathematischen Wissenschaften 360
- `Fischer1976Complex` Fischer 1976, *Complex Analytic Geometry* (?) [1·B] — Lecture Notes in Math. 538
- `Forstneric2017Stein` Forstnerič 2017, *Stein Manifolds and Holomorphic Mappings* (?) [1·B] — Ergebnisse der Mathematik und ihrer Grenzgebiete (3) 56
- `Freitag1983Siegelsche` Freitag 1983, *Siegelsche Modulfunktionen* (?) [1·B] — Grundlehren der mathematischen Wissenschaften 254
- `Freitag1990Hilbert` Freitag 1990, *Hilbert Modular Forms* (?) [1·B] — —
- `FultonHarris1991Representation` Fulton–Harris 1991, *Representation Theory* (?) [1·B] — Graduate Texts in Mathematics 129
- `Geer1988Hilbert` van der Geer 1988, *Hilbert Modular Surfaces* (?) [1·B] — Ergebnisse der Mathematik (3) 16
- `GodementJacquet1972Zeta` Godement–Jacquet 1972, *Zeta Functions of Simple Algebras* (?) [1·B] — Lecture Notes in Mathematics 260
- `GrauertRemmert1984Coherent` Grauert–Remmert 1984, *Coherent Analytic Sheaves* (?) [1·B] — Grundlehren 265
- `GreuelLossenShustin2007Singularities` Greuel–Lossen–Shustin 2007, *Singularities and Deformations* (?) [1·B] — Monographs in Math.
- `Grimmett2006Random` Grimmett 2006, *Random-Cluster Model* (?) [1·B] — Grundlehren der mathematischen Wissenschaften 333
- `Gromov1986Partial` Gromov 1986, *Partial Differential Relations* (?) [1·B] — Ergebnisse der Mathematik und ihrer Grenzgebiete (3) 9
- `Grothendieck1972Groupes` Grothendieck 1972, *Groupes de monodromie en géométrie algébrique (SGA 7 I)* (?) [1·B] — Lecture Notes in Math. 288
- `HarrisMorrison1998Moduli` Harris–Morrison 1998, *Moduli of Curves* (?) [1·B] — Graduate Texts in Math. 187
- `Hirzebruch1966Topological` Hirzebruch 1966, *Topological Methods in Algebraic Geometry* (?) [1·B] — Grundlehren der mathematischen Wissenschaften 131
- `HoferZehnder1994Symplectic` Hofer–Zehnder 1994, *Symplectic Invariants and Hamiltonian Dynamics* (?) [1·B] — Advanced Texts
- `Hsiang1975Cohomology` Hsiang 1975, *Cohomology Theory of Topological Transformation Groups* (?) [1·B] — Ergebnisse der Mathematik und ihrer Grenzgebiete 85
- `Husemoller1994Fibre` Husemoller 1994, *Fibre Bundles* (?) [1·B] — Graduate Texts in Mathematics 20
- `Illusie1971Complexe` Illusie 1971, *Complexe cotangent et déformations I, II* (?) [1·B] — Lecture Notes in Math. 239, 283
- `ImayoshiTaniguchi1992Teichmuller` Imayoshi–Taniguchi 1992, *Teichmüller Spaces* (?) [1·B] — Tokyo
- `Isakov2017Inverse` Isakov 2017, *Inverse Problems for Partial Differential Equations* (?) [1·B] — Applied Mathematical Sciences 127
- `Iversen1986Cohomology` Iversen 1986, *Cohomology of Sheaves* (?) [1·B] — Universitext
- `Johannson1979Homotopy` Johannson 1979, *Homotopy Equivalences of 3-Manifolds with Boundaries* (?) [1·B] — Lecture Notes in Mathematics 761
- `Jouanolou1983Theoremes` Jouanolou 1983, *Théorèmes de Bertini et applications* (?) [1·B] — Progress in Math. 42
- `Kallenberg2005Probabilistic` Kallenberg 2005, *Probabilistic Symmetries and Invariance Principles* (?) [1·B] — Probability and Its Applications
- `Kammeyer2019L2` Kammeyer 2019, *ℓ²-Invariants* (?) [1·B] — Lecture Notes in Mathematics 2247
- `Kapovich2001Hyperbolic` Kapovich 2001, *Hyperbolic Manifolds and Discrete Groups* (?) [1·B] — Progress in Mathematics 183
- `Karoubi1978K` Karoubi 1978, *K-Theory: An Introduction* (?) [1·B] — Grundlehren der mathematischen Wissenschaften 226
- `KashiwaraSchapira2006Categories` Kashiwara–Schapira 2006, *Categories and Sheaves* [1·B] — Grundlehren der mathematischen Wissenschaften 332
- `KasselTuraev2008Braid` Kassel–Turaev 2008, *Braid Groups* (?) [1·B] — Graduate Texts in Mathematics 247
- `Kato1976Perturbation` Kato 1976, *Perturbation Theory for Linear Operators* (?) [1·B] — Grundlehren der mathematischen Wissenschaften 132
- `Klingenberg1978Lectures` Klingenberg 1978, *Closed Geodesics* (?) [1·B] — Grundlehren der mathematischen Wissenschaften 230
- `Knapp2002Lie` Knapp 2002, *Lie Groups Beyond an Introduction* (?) [1·B] — Progress in Mathematics 140
- `Kneser2002Quadratische` Kneser 2002, *Quadratische Formen (revised with R. Scharlau)* (?) [1·B] — —
- `Kobayashi1998Hyperbolic` Kobayashi 1998, *Hyperbolic Complex Spaces* (?) [1·B] — Grundlehren der mathematischen Wissenschaften 318
- `KrantzParks2008Geometric` Krantz–Parks 2008, *Geometric Integration Theory* (?) [1·B] — Cornerstones
- `Lang1987Complex` Lang 1987, *Complex Hyperbolic Spaces* (?) [1·B] — —
- `LepowskyLi2004Vertex` Lepowsky–Li 2004, *Vertex Operator Algebras and Their Representations* (?) [1·B] — Progress in Mathematics 227
- `Lindqvist2016Notes` Lindqvist 2016, *Infinity Laplace Equation* (?) [1·B] — SpringerBriefs in Mathematics
- `MalleMatzat2018Inverse` Malle–Matzat 2018, *Inverse Galois Theory* [1·B] — Monographs in Mathematics
- `Margulis1991Discrete` Margulis 1991, *Discrete Subgroups of Semisimple Lie Groups* (?) [1·B] — Ergebnisse der Mathematik und ihrer Grenzgebiete (3) 17
- `Martinet2003Perfect` Martinet 2003, *Perfect Lattices in Euclidean Spaces* (?) [1·B] — Grundlehren der mathematischen Wissenschaften 327
- `Matveev2007Algorithmic` Matveev 2007, *Algorithmic Topology and Classification of 3-Manifolds* (?) [1·B] — Algorithms and Computation in Mathematics 9
- `Messing1972Crystals` Messing 1972, *Crystals Associated to Barsotti–Tate Groups* (?) [1·B] — Lecture Notes in Math. 264
- `MezardMontanari2009Information` Mézard–Montanari 2009, *Information, Physics, and Computation* (?) [1·B] — Oxford Graduate Texts
- `MilmanSchechtman1986Asymptotic` Milman–Schechtman 1986, *Asymptotic Theory of Finite Dimensional Normed Spaces* (?) [1·B] — Lecture Notes in Mathematics 1200
- `MoeglinVignerasWaldspurger1987Correspondances` Mœglin–Vignéras–Waldspurger 1987, *Correspondances de Howe sur un Corps p-adique* (?) [1·B] — Lecture Notes in Mathematics 1291
- `Moise1977Geometric` Moise 1977, *Geometric Topology in Dimensions 2 and 3* (?) [1·B] — Graduate Texts in Mathematics 47
- `OkonekSchneiderSpindler1980Vector` Okonek–Schneider–Spindler 1980, *Vector Bundles on Complex Projective Spaces* (?) [1·B] — Progress in Math. 3
- `OMeara1963Quadratic` O'Meara 1963, *Quadratic Forms* [1·B] — Grundlehren der mathematischen Wissenschaften 117
- `Oort1966Commutative` Oort 1966, *Commutative Group Schemes* (?) [1·B] — Lecture Notes in Math. 15
- `Panchenko2013Sherrington` Panchenko 2013, *Sherrington–Kirkpatrick Model* (?) [1·B] — Monographs in Mathematics
- `Paternain1999Geodesic` Paternain 1999, *Geodesic Flows* (?) [1·B] — Progress in Mathematics 180
- `Polterovich2001Geometry` Polterovich 2001, *Geometry of the Group of Symplectic Diffeomorphisms* (?) [1·B] — Lectures in Mathematics ETH Zürich
- `Ratcliffe2019Foundations` Ratcliffe 2019, *Foundations of Hyperbolic Manifolds* (?) [1·B] — Graduate Texts in Mathematics 149
- `RobertsSchmidt2007Local` Roberts–Schmidt 2007, *Local Newforms for GSp(4)* (?) [1·B] — Lecture Notes in Mathematics 1918
- `Schmidt1980Diophantine` Schmidt 1980, *Diophantine Approximation* (?) [1·B] — Lecture Notes in Mathematics 785
- `Schurmann2003Topology` Schürmann 2003, *Topology of Singular Spaces and Constructible Sheaves* (?) [1·B] — Monografie Matematyczne (New Series) 63
- `Siburg2004Principle` Siburg 2004, *Principle of Least Action in Geometry and Dynamics* (?) [1·B] — Lecture Notes in Math. 1844
- `Silverman2009Arithmetic` Silverman 2009, *Arithmetic of Elliptic Curves* (?) [1·B] — Graduate Texts in Mathematics 106
- `Talagrand2011Mean` Talagrand 2011, *Mean Field Models for Spin Glasses, Vols. I–II* (?) [1·B] — Ergebnisse der Mathematik und ihrer Grenzgebiete (3) 54–55
- `Tasaki2020Physics` Tasaki 2020, *Physics and Mathematics of Quantum Many-Body Systems* (?) [1·B] — Graduate Texts in Physics
- `Tate1984Conjectures` Tate 1984, *Les Conjectures de Stark sur les Fonctions L d'Artin en s =…* (?) [1·B] — Progress in Mathematics 47
- `Tolsa2014Analytic` Tolsa 2014, *Analytic Capacity, the Cauchy Transform, and…* (?) [1·B] — Progress in Mathematics 307
- `Waldschmidt2000Diophantine` Waldschmidt 2000, *Diophantine Approximation on Linear Algebraic Groups* [1·B] — Grundlehren der mathematischen Wissenschaften 326
- `Weidmann1987Spectral` Weidmann 1987, *Spectral Theory of Ordinary Differential Operators* (?) [1·B] — Lecture Notes in Mathematics 1258
- `Zong1999Sphere` Zong 1999, *Sphere Packings* (?) [1·B] — Universitext
- `Bellaiche2021Eigenbook` Bellaïche 2021, *Eigenbook* (?) [1·C] — Pathways in Mathematics
- `CarmonaLacroix1990Spectral` Carmona–Lacroix 1990, *Spectral Theory of Random Schrödinger Operators* (?) [1·C] — Probability and Its Applications
- `Cohen1973Course` Cohen 1973, *Simple-Homotopy Theory* (?) [1·C] — Graduate Texts in Mathematics 10
- `ConnerFloyd1966Relation` Conner–Floyd 1966, *Relation of Cobordism to K-Theories* (?) [1·C] — Lecture Notes in Mathematics 28
- `Deligne1970Equations` Deligne 1970, *Équations différentielles à points singuliers réguliers* (?) [1·C] — Lecture Notes in Math. 163
- `DundasGoodwillieMcCarthy2013Local` Dundas–Goodwillie–McCarthy 2013, *Local Structure of Algebraic K-Theory* (?) [1·C] — Algebra and Applications 18
- `EliasEtAl2020Soergel` Elias et al. 2020, *Soergel Bimodules* (?) [1·C] — RSME Series 5
- `FreedUhlenbeck1991Instantons` Freed–Uhlenbeck 1991, *Instantons and Four-Manifolds* (?) [1·C] — MSRI Publications 1
- `FreitagKiehl1988Etale` Freitag–Kiehl 1988, *Étale Cohomology and the Weil Conjecture* (?) [1·C] — Ergebnisse der Math. (3) 13
- `FultonLang1985Riemann` Fulton–Lang 1985, *Riemann–Roch Algebra* (?) [1·C] — Grundlehren der mathematischen Wissenschaften 277
- `GlimmJaffe1987Quantum` Glimm–Jaffe 1987, *Quantum Physics* (?) [1·C] — —
- `GrossHuybrechtsJoyce2003Calabi` Gross–Huybrechts–Joyce 2003, *Calabi–Yau Manifolds and Related Geometries* (?) [1·C] — Universitext
- `GuillenEtAl1988Hyperresolutions` Guillén et al. 1988, *Hyperrésolutions cubiques et descente cohomologique* (?) [1·C] — Lecture Notes in Math. 1335
- `Haag1996Local` Haag 1996, *Local Quantum Physics* (?) [1·C] — Texts and Monographs in Physics
- `Kemppainen2017Schramm` Kemppainen 2017, *Schramm–Loewner Evolution* (?) [1·C] — SpringerBriefs in Mathematical Physics
- `Kirby1989Topology` Kirby 1989, *Topology of 4-Manifolds* (?) [1·C] — Lecture Notes in Mathematics 1374
- `LewisMaySteinberger1986Equivariant` Lewis–May–Steinberger 1986, *Equivariant Stable Homotopy Theory* (?) [1·C] — Lecture Notes in Mathematics 1213
- `Loday1998Cyclic` Loday 1998, *Cyclic Homology* (?) [1·C] — Grundlehren der mathematischen Wissenschaften 301
- `Mantegazza2011Lecture` Mantegazza 2011, *Mean Curvature Flow* (?) [1·C] — Progress in Mathematics 290
- `PasturFigotin1992Spectra` Pastur–Figotin 1992, *Spectra of Random and Almost-Periodic Operators* (?) [1·C] — Grundlehren der mathematischen Wissenschaften 297
- `Serre1997Galois` Serre 1997, *Galois Cohomology* [1·C] — Monographs in Mathematics
- `Silverman2007Arithmetic` Silverman 2007, *Arithmetic of Dynamical Systems* (?) [1·C] — Graduate Texts in Mathematics 241
- `Tian2000Canonical` Tian 2000, *Canonical Metrics in Kähler Geometry* (?) [1·C] — Lectures in Mathematics ETH Zürich
- `Varadarajan1985Geometry` Varadarajan 1985, *Geometry of Quantum Theory* (?) [1·C] — —

**Journal papers (265)**

- *Invent. Math.* (96): `Diamond1997Taylor` Diamond 1997, *Taylor-Wiles construction and multiplicity one* [4·A]; `Bass1976Euler` Bass 1976, *Euler characteristics and characters of discrete groups* (?) [2·A]; `BayerStillman1987Criterion` Bayer–Stillman 1987, *Criterion for detecting m-regularity* (?) [1·A]; `BierstoneMilman1997Canonical` Bierstone–Milman 1997, *Canonical desingularization in characteristic zero by…* (?) [1·A]; `BourgainMilman1987New` Bourgain–Milman 1987, *New volume ratio properties for convex symmetric bodies in…* (?) [1·A]; `Brown1975Euler` Brown 1975, *Euler characteristics of groups* (?) [1·A]; `Demazure1976Very` Demazure 1976, *Very simple proof of Bott's theorem* (?) [1·A]; `Donkin1992Invariants` Donkin 1992, *Invariants of several matrices* (?) [1·A]; `Dunwoody1985Accessibility` Dunwoody 1985, *Accessibility of finitely presented groups* (?) [1·A]; `Eliashberg1989Classification` Eliashberg 1989, *Classification of overtwisted contact structures on…* (?) [1·A]; `FrenkelKac1980Basic` Frenkel–Kac 1980, *Basic representations of affine Lie algebras and dual…* (?) [1·A]; `Gromov1985Pseudoholomorphic` Gromov 1985, *Pseudoholomorphic curves in symplectic manifolds* (?) [1·A]; `Gupta2014Cancellation` Gupta 2014, *Cancellation problem for the affine space A³ in…* (?) [1·A]; `KazhdanLusztig1979Representations` Kazhdan–Lusztig 1979, *Representations of Coxeter groups and Hecke algebras* (?) [1·A]; `Kiehl1967Endlichkeitssatz` Kiehl 1967, *Der Endlichkeitssatz für eigentliche Abbildungen in der…* (?) [1·A]; `Lieb1990Gaussian` Lieb 1990, *Gaussian kernels have only Gaussian maximizers* (?) [1·A]; `Lindenstrauss2001Pointwise` Lindenstrauss 2001, *Pointwise theorems for amenable groups* (?) [1·A]; `Littelmann1994Littlewood` Littelmann 1994, *Littlewood–Richardson rule for symmetrizable Kac–Moody…* (?) [1·A]; `Macdonald1972Affine` Macdonald 1972, *Affine root systems and Dedekind's η-function* (?) [1·A]; `Milnor1970Algebraic` Milnor 1970, *Algebraic K-theory and quadratic forms* [1·A]; `Pop2012Birational` Pop 2012, *Birational anabelian program initiated by Bogomolov I* [1·A]; `RamananRamanathan1985Projective` Ramanan–Ramanathan 1985, *Projective normality of flag varieties and Schubert…* (?) [1·A]; `Vistoli1989Intersection` Vistoli 1989, *Intersection theory on algebraic stacks and on their moduli…* (?) [1·A]; `Wlodarczyk2003Toroidal` Włodarczyk 2003, *Toroidal varieties and the weak factorization theorem* (?) [1·A]; `McDuffSegal1976Homology` McDuff–Segal 1976, *Homology fibrations and the "group-completion" theorem* (?) [2·B]; `MoyPrasad1994Unrefined` Moy–Prasad 1994, *Unrefined minimal K-types for p-adic groups* (?) [2·B]; `Andre2002Filtrations` André 2002, *Filtrations de type Hasse–Arf et monodromie p-adique* (?) [1·B]; `AngehrnSiu1995Effective` Angehrn–Siu 1995, *Effective freeness and point separation for adjoint bundles* (?) [1·B]; `Behrend1993Lefschetz` Behrend 1993, *Lefschetz trace formula for algebraic stacks* (?) [1·B]; `BestvinaBrady1997Morse` Bestvina–Brady 1997, *Morse theory and finiteness properties of groups* (?) [1·B]; `BianeCapitaineGuionnet2003Large` Biane–Capitaine–Guionnet 2003, *Large deviation bounds for matrix Brownian motion* (?) [1·B]; `BombieriGiorgiGiusti1969Minimal` Bombieri–De Giorgi–Giusti 1969, *Minimal cones and the Bernstein problem* (?) [1·B]; `BombieriMumford1977Enriques` Bombieri–Mumford 1977, *Enriques' classification of surfaces in char. p, II* (?) [1·B]; `BrieskornSaito1972Artin` Brieskorn–Saito 1972, *Artin-Gruppen und Coxeter-Gruppen* (?) [1·B]; `BrylinskiKashiwara1981Kazhdan` Brylinski–Kashiwara 1981, *Kazhdan–Lusztig conjecture and holonomic systems* (?) [1·B]; `CherbonnierColmez1998Representations` Cherbonnier–Colmez 1998, *Représentations p-adiques surconvergentes* (?) [1·B]; `Deligne1969Varietes` Deligne 1969, *Variétés abéliennes ordinaires sur un corps fini* (?) [1·B]; `Deligne1972Immeubles` Deligne 1972, *Les immeubles des groupes de tresses généralisés* (?) [1·B]; `DeligneEtAl1975Real` Deligne et al. 1975, *Real homotopy theory of Kähler manifolds* (?) [1·B]; `DeligneIllusie1987Relevements` Deligne–Illusie 1987, *Relèvements modulo p² et décomposition du complexe de de…* (?) [1·B]; `DonnellyFefferman1988Nodal` Donnelly–Fefferman 1988, *Nodal sets of eigenfunctions on Riemannian manifolds* (?) [1·B]; `DuistermaatHeckman1982Variation` Duistermaat–Heckman 1982, *Variation in the cohomology of the symplectic form of the…* (?) [1·B]; `Franks1992Geodesics` Franks 1992, *Geodesics on S² and periodic points of annulus…* (?) [1·B]; `Gaboriau2000Cout` Gaboriau 2000, *Coût des relations d'équivalence et des groupes* (?) [1·B]; `GoreskyKottwitzMacPherson1998Equivariant` Goresky–Kottwitz–MacPherson 1998, *Equivariant cohomology, Koszul duality, and the…* (?) [1·B]; `GoreskyMacPherson1983Intersection` Goresky–MacPherson 1983, *Intersection homology II* (?) [1·B]; `GrauertRiemenschneider1970Verschwindungssatze` Grauert–Riemenschneider 1970, *Verschwindungssätze für analytische Kohomologiegruppen auf…* (?) [1·B]; `Haagerup1979Example` Haagerup 1979, *Example of a non nuclear C*-algebra, which has the metric…* (?) [1·B]; `Harder1987Eisenstein` Harder 1987, *Eisenstein cohomology of arithmetic groups. The case GL2* (?) [1·B]; `Inoue1974Surfaces` Inoue 1974, *Surfaces of class VII_0* (?) [1·B]; `Jones1990Rectifiable` Jones 1990, *Rectifiable sets and the traveling salesman problem* (?) [1·B]; `Kashiwara1976B` Kashiwara 1976, *B-functions and holonomic systems* (?) [1·B]; `KebekusEtAl2000Projective` Kebekus et al. 2000, *Projective contact manifolds* (?) [1·B]; `LaudenbachSikorav1985Persistance` Laudenbach–Sikorav 1985, *Persistance d'intersection avec la section nulle au cours…* (?) [1·B]; `Maass1979Spezialschar` Maass 1979, *Über eine Spezialschar von Modulformen zweiten Grades I-III* (?) [1·B]; `McDuffPolterovich1994Symplectic` McDuff–Polterovich 1994, *Symplectic packings and algebraic geometry* (?) [1·B]; `Mebkhout2002Analogue` Mebkhout 2002, *Analogue p-adique du théorème de Turrittin et le théorème…* (?) [1·B]; `Miyaoka1977Chern` Miyaoka 1977, *Chern numbers of surfaces of general type* (?) [1·B]; `Mumford1966Equations` Mumford 1966, *Equations defining abelian varieties I* (?) [1·B]; `NakamuraUhlmann1994Global` Nakamura–Uhlmann 1994, *Global uniqueness for an inverse boundary problem arising…* (?) [1·B]; `Prasad1973Strong` Prasad 1973, *Strong rigidity of Q-rank 1 lattices* (?) [1·B]; `Radulescu1994Random` Rădulescu 1994, *Random matrices, amalgamated free products and subfactors…* (?) [1·B]; `Salvetti1987Topology` Salvetti 1987, *Topology of the complement of real hyperplanes in C^N* (?) [1·B]; `Siu1974Analyticity` Siu 1974, *Analyticity of sets associated to Lelong numbers and the…* (?) [1·B]; `Stark1974Effective` Stark 1974, *Some effective cases of the Brauer-Siegel theorem* (?) [1·B]; `Stevens1989Stickelberger` Stevens 1989, *Stickelberger elements and modular parametrizations of…* (?) [1·B]; `Tate1966Endomorphisms` Tate 1966, *Endomorphisms of abelian varieties over finite fields* [1·B]; `Voiculescu1994Analogues` Voiculescu 1994, *Analogues of entropy and of Fisher's information measure in… II* (?) [1·B]; `Voiculescu1998Analogues` Voiculescu 1998, *Analogues of entropy and of Fisher's information measure in…* (?) [1·B]; `Zarhin1985Finiteness` Zarhin 1985, *Finiteness theorem for unpolarized abelian varieties over…* (?) [1·B]; `GrossZagier1986Heegner` Gross–Zagier 1986, *Heegner points and derivatives of L-series* [2·C]; `Hida1986Galois` Hida 1986, *Galois representations into GL_2(Z_p[[X]]) attached to…* (?) [2·C]; `Behrend1997Gromov` Behrend 1997, *Gromov–Witten invariants in algebraic geometry* (?) [1·C]; `BokstedtHsiangMadsen1993Cyclotomic` Bökstedt–Hsiang–Madsen 1993, *Cyclotomic trace and algebraic K-theory of spaces* (?) [1·C]; `Borel1976Admissible` Borel 1976, *Admissible representations of a semi-simple group over a…* (?) [1·C]; `Cao1985Deformation` Cao 1985, *Deformation of Kähler metrics to Kähler–Einstein metrics on…* (?) [1·C]; `Coleman1997P` Coleman 1997, *p-adic Banach spaces and families of modular forms* [1·C]; `Dani1981Invariant` Dani 1981, *Invariant measures and minimal sets of horospherical flows* (?) [1·C]; `Deligne1972Conjecture` Deligne 1972, *La conjecture de Weil pour les surfaces K3* (?) [1·C]; `DeligneRibet1980Values` Deligne–Ribet 1980, *Values of abelian L-functions at negative integers over…* (?) [1·C]; `Emerton2006Interpolation` Emerton 2006, *Interpolation of systems of eigenvalues attached to…* (?) [1·C]; `Fontaine1985Il` Fontaine 1985, *Il n'y a pas de variété abélienne sur Z* [1·C]; `Harris1985Arithmetic` Harris 1985, *Arithmetic vector bundles and automorphic forms on Shimura… I* (?) [1·C]; `Kobayashi2003Iwasawa` Kobayashi 2003, *Iwasawa theory for elliptic curves at supersingular primes* (?) [1·C]; `Lafforgue2002Chtoucas` Lafforgue 2002, *Chtoucas de Drinfeld et correspondance de Langlands* (?) [1·C]; `LaumonRapoportStuhler1993D` Laumon–Rapoport–Stuhler 1993, *D-elliptic sheaves and the Langlands correspondence* [1·C]; `Ribet1976Modular` Ribet 1976, *Modular construction of unramified p-extensions of Q(mu_p)* (?) [1·C]; `Rubin1987Tate` Rubin 1987, *Tate-Shafarevich groups and L-functions of elliptic curves…* [1·C]; `Schmid1973Variation` Schmid 1973, *Variation of Hodge structure* (?) [1·C]; `Siu1983Every` Siu 1983, *Every K3 surface is Kähler* (?) [1·C]; `SiuYau1980Compact` Siu–Yau 1980, *Compact Kähler manifolds of positive bisectional curvature* (?) [1·C]; `SkinnerUrban2014Iwasawa` Skinner–Urban 2014, *Iwasawa main conjectures for GL_2* (?) [1·C]; `Soule1979K` Soulé 1979, *K-théorie des anneaux d'entiers de corps de nombres et…* (?) [1·C]; `Suslin1983K` Suslin 1983, *K-theory of algebraically closed fields* (?) [1·C]; `Tian1997Kahler` Tian 1997, *Kähler–Einstein metrics with positive scalar curvature* (?) [1·C]; `Todorov1980Applications` Todorov 1980, *Applications of the Kähler–Einstein–Calabi–Yau metric to…* (?) [1·C]
- *Comm. Math. Phys.* (23): `Caffarelli2000Monotonicity` Caffarelli 2000, *Monotonicity properties of optimal transportation and the…* (?) [1·A]; `Epstein1973Remarks` Epstein 1973, *Remarks on two theorems of E. Lieb* (?) [1·A]; `HeilmannLieb1972Theory` Heilmann–Lieb 1972, *Theory of monomer-dimer systems* (?) [1·A]; `Kesten1987Scaling` Kesten 1987, *Scaling relations for 2D-percolation* (?) [1·A]; `Sideris1985Formation` Sideris 1985, *Formation of singularities in three-dimensional…* (?) [1·A]; `Borchers1992CPT` Borchers 1992, *CPT-theorem in two-dimensional theories of local observables* (?) [2·B]; `ChoquetBruhatGeroch1969Global` Choquet-Bruhat–Geroch 1969, *Global aspects of the Cauchy problem in general relativity* (?) [2·B]; `CombesThomas1973Asymptotic` Combes–Thomas 1973, *Asymptotic behaviour of eigenfunctions for multiparticle…* (?) [1·B]; `FannesNachtergaeleWerner1992Finitely` Fannes–Nachtergaele–Werner 1992, *Finitely correlated states on quantum spin chains* (?) [1·B]; `GidasNiNirenberg1979Symmetry` Gidas–Ni–Nirenberg 1979, *Symmetry and related properties via the maximum principle* (?) [1·B]; `McBryanSpencer1977Decay` McBryan–Spencer 1977, *Decay of correlations in SO(n)-symmetric ferromagnets* (?) [1·B]; `Nachtergaele1996Spectral` Nachtergaele 1996, *Spectral gap for some spin chains with discrete symmetry…* (?) [1·B]; `Ruelle1970Superstable` Ruelle 1970, *Superstable interactions in classical statistical mechanics* (?) [1·B]; `SchoenYau1979Proof` Schoen–Yau 1979, *Proof of the positive mass conjecture in general relativity* (?) [1·B]; `Wiesbrock1993Half` Wiesbrock 1993, *Half-sided modular inclusions of von-Neumann-algebras* (?) [1·B]; `AizenmanMolchanov1993Localization` Aizenman–Molchanov 1993, *Localization at large disorder and at extreme energies* (?) [1·C]; `DoplicherHaagRoberts1971Local` Doplicher–Haag–Roberts 1971, *Local observables and particle statistics. I* (?) [1·C]; `Floer1988Instanton` Floer 1988, *Instanton-invariant for 3-manifolds* (?) [1·C]; `HitchinEtAl1987Hyperkahler` Hitchin et al. 1987, *Hyperkähler metrics and supersymmetry* (?) [1·C]; `KunzSouillard1980Spectre` Kunz–Souillard 1980, *Sur le spectre des opérateurs aux différences finies…* (?) [1·C]; `OsterwalderSchrader1975Axioms` Osterwalder–Schrader 1975, *Axioms for Euclidean Green's functions. II* (?) [1·C]; `Pastur1980Spectral` Pastur 1980, *Spectral properties of disordered systems in the one-body…* (?) [1·C]; `Slawny1972Factor` Slawny 1972, *Factor representations and the C*-algebra of canonical…* (?) [1·C]
- *Acta Math.* (?) (20): `Arveson1972Subalgebras` Arveson 1972, *Subalgebras of C*-algebras. II* (?) [1·A]; `Branges1985Proof` de Branges 1985, *Proof of the Bieberbach conjecture* (?) [1·A]; `Enflo1973Counterexample` Enflo 1973, *Counterexample to the approximation problem in Banach spaces* (?) [1·A]; `Halasz1968Mittelwerte` Halász 1968, *Über die Mittelwerte multiplikativer zahlentheoretischer…* [1·A]; `Sturm2006Geometry` Sturm 2006, *Geometry of metric measure spaces I* [1·A]; `AmbrosioKirchheim2000Currents` Ambrosio–Kirchheim 2000, *Currents in metric spaces* (?) [1·B]; `AtiyahBott1964Periodicity` Atiyah–Bott 1964, *Periodicity theorem for complex vector bundles* (?) [1·B]; `BedfordTaylor1982New` Bedford–Taylor 1982, *New capacity for plurisubharmonic functions* (?) [1·B]; `GordonEtAl1997Duality` Gordon et al. 1997, *Duality and singular continuous spectrum in the almost…* (?) [1·B]; `Haagerup1987Connes` Haagerup 1987, *Connes' bicentralizer problem and uniqueness of the…* (?) [1·B]; `HaagerupMunkholm1981Simplices` Haagerup–Munkholm 1981, *Simplices of maximal volume in hyperbolic n-space* (?) [1·B]; `Haken1961Theorie` Haken 1961, *Theorie der Normalflächen* (?) [1·B]; `HarveyLawson1982Calibrated` Harvey–Lawson 1982, *Calibrated geometries* (?) [1·B]; `JitomirskayaLast1999Power` Jitomirskaya–Last 1999, *Power-law subordinacy and singular spectra. I. Half-line…* (?) [1·B]; `Kolodziej1998Complex` Kołodziej 1998, *Complex Monge–Ampère equation* (?) [1·B]; `Lech1964Inequalities` Lech 1964, *Inequalities related to certain couples of local rings* (?) [1·B]; `MatuiSato2012Strict` Matui–Sato 2012, *Strict comparison and Z-absorption of nuclear C*-algebras* (?) [1·B]; `Weil1964Certains` Weil 1964, *Sur certains groupes d'opérateurs unitaires* (?) [1·B]; `FouresBruhat1952Theoreme` Fourès-Bruhat 1952, *Théorème d'existence pour certains systèmes d'équations aux…* (?) [1·C]; `GriffithsSchmid1969Locally` Griffiths–Schmid 1969, *Locally homogeneous complex manifolds* (?) [1·C]
- *Publ. Math. IHÉS* (18): `Jong1996Smoothness` de Jong 1996, *Smoothness, semi-stability and alterations* (?) [2·A]; `IwahoriMatsumoto1965Bruhat` Iwahori–Matsumoto 1965, *Some Bruhat decomposition and the structure of the Hecke…* (?) [1·A]; `Shalom1999Bounded` Shalom 1999, *Bounded generation and Kazhdan's property (T)* (?) [1·A]; `Sullivan1977Infinitesimal` Sullivan 1977, *Infinitesimal computations in topology* (?) [1·A]; `Artin1969Algebraic` Artin 1969, *Algebraic approximation of structures over complete local…* (?) [1·B]; `GilletSoule1990Arithmetic` Gillet–Soulé 1990, *Arithmetic intersection theory* (?) [1·B]; `Grauert1960Theorem` Grauert 1960, *Ein Theorem der analytischen Garbentheorie und die…* (?) [1·B]; `Gromov1982Volume` Gromov 1982, *Volume and bounded cohomology* (?) [1·B]; `KazhdanPatterson1984Metaplectic` Kazhdan–Patterson 1984, *Metaplectic forms* (?) [1·B]; `Mumford1961Topology` Mumford 1961, *Topology of normal singularities of an algebraic surface…* (?) [1·B]; `Simpson1992Higgs` Simpson 1992, *Higgs bundles and local systems* (?) [1·B]; `Simpson1994Moduli` Simpson 1994, *Moduli of representations of the fundamental group of a… II* (?) [1·B]; `Deligne1974Theorie` Deligne 1974, *Théorie de Hodge III* (?) [1·C]; `Griffiths1968Periods` Griffiths 1968, *Periods of integrals on algebraic manifolds I, II* (?) [1·C]; `Grothendieck1966Rham` Grothendieck 1966, *De Rham cohomology of algebraic varieties* (?) [1·C]; `Hartshorne1975Rham` Hartshorne 1975, *De Rham cohomology of algebraic varieties* (?) [1·C]; `MorelVoevodsky1999A1` Morel–Voevodsky 1999, *A¹-homotopy theory of schemes* (?) [1·C]; `Voevodsky2003Motivic` Voevodsky 2003, *Motivic cohomology with Z/2-coefficients* (?) [1·C]
- *Math. Ann.* (17): `CollinsHuebschmann1982Spherical` Collins–Huebschmann 1982, *Spherical diagrams and identities among relations* (?) [1·A]; `Hilbert1890Theorie` Hilbert 1890, *Über die Theorie der algebraischen Formen* (?) [1·A]; `KaniRosen1989Idempotent` Kani–Rosen 1989, *Idempotent relations and factors of Jacobians* (?) [1·A]; `KuboAndo1980Means` Kubo–Ando 1980, *Means of positive linear operators* (?) [1·A]; `SaintDonat1973Petri` Saint-Donat 1973, *Petri's analysis of the linear system of quadrics through a…* (?) [1·A]; `GhoussoubGui1998Conjecture` Ghoussoub–Gui 1998, *Conjecture of De Giorgi and some related problems* (?) [1·B]; `Grauert1958Analytische` Grauert 1958, *Analytische Faserungen über holomorph-vollständigen Räumen* (?) [1·B]; `Grauert1962Modifikationen` Grauert 1962, *Über Modifikationen und exzeptionelle analytische Mengen* (?) [1·B]; `Kawamata1982Generalization` Kawamata 1982, *Generalization of Kodaira–Ramanujam's vanishing theorem* (?) [1·B]; `Monsky1983Hilbert` Monsky 1983, *Hilbert–Kunz function* (?) [1·B]; `Remmert1957Holomorphe` Remmert 1957, *Holomorphe und meromorphe Abbildungen komplexer Räume* (?) [1·B]; `RemmertStein1953Wesentlichen` Remmert–Stein 1953, *Über die wesentlichen Singularitäten analytischer Mengen* (?) [1·B]; `Viterbo1992Symplectic` Viterbo 1992, *Symplectic topology as the geometry of generating functions* (?) [1·B]; `CastellaHsieh2018Heegner` Castella–Hsieh 2018, *Heegner cycles and p-adic L-functions* [1·C]; `Huber1993Etale` Huber 1993, *Étale cohomology of Henselian rings and cohomology of…* (?) [1·C]; `KugaSatake1967Abelian` Kuga–Satake 1967, *Abelian varieties attached to polarized K3 surfaces* (?) [1·C]; `LanglandsShelstad1987Definition` Langlands–Shelstad 1987, *Definition of transfer factors* (?) [1·C]
- *Combinatorica* (15): `Aharoni2001Ryser` Aharoni 2001, *Ryser's conjecture for tripartite 3-graphs* (?) [1·A]; `Alon1986Eigenvalues` Alon 1986, *Eigenvalues and expanders* (?) [1·A]; `AlonEtAl2000Efficient` Alon et al. 2000, *Efficient testing of large graphs* (?) [1·A]; `BiluLinial2006Lifts` Bilu–Linial 2006, *Lifts, discrepancy and nearly optimal spectral gap* (?) [1·A]; `CaiFurerImmerman1992Optimal` Cai–Fürer–Immerman 1992, *Optimal lower bound on the number of variables for graph…* (?) [1·A]; `FranklWilson1981Intersection` Frankl–Wilson 1981, *Intersection theorems with geometric consequences* (?) [1·A]; `Friedgut1998Boolean` Friedgut 1998, *Boolean functions with low average sensitivity depend on…* (?) [1·A]; `GotsmanLinial1994Spectral` Gotsman–Linial 1994, *Spectral properties of threshold functions* (?) [1·A]; `GuptaEtAl2004Cuts` Gupta et al. 2004, *Cuts, trees and ℓ₁-embeddings of graphs* (?) [1·A]; `KimVu2000Concentration` Kim–Vu 2000, *Concentration of multivariate polynomials and its…* (?) [1·A]; `KollarRonyaiSzabo1996Norm` Kollár–Rónyai–Szabó 1996, *Norm-graphs and bipartite Turán numbers* (?) [1·A]; `KomlosSarkozySzemeredi1997Blow` Komlós–Sárközy–Szemerédi 1997, *Blow-up lemma* (?) [1·A]; `LinialLondonRabinovich1995Geometry` Linial–London–Rabinovich 1995, *Geometry of graphs and some of its algorithmic applications* (?) [1·A]; `LubotzkyPhillipsSarnak1988Ramanujan` Lubotzky–Phillips–Sarnak 1988, *Ramanujan graphs* (?) [1·A]; `Nisan1992Pseudorandom` Nisan 1992, *Pseudorandom generators for space-bounded computation* (?) [1·B]
- *Compositio Math.* (10): `CallSilverman1993Canonical` Call–Silverman 1993, *Canonical heights on varieties with morphisms* (?) [2·B]; `Cremona1984Hyperbolic` Cremona 1984, *Hyperbolic tessellations, modular symbols, and elliptic…* (?) [1·B]; `Mebkhout1984Autre` Mebkhout 1984, *Une autre équivalence de catégories* (?) [1·B]; `Spaltenstein1988Resolutions` Spaltenstein 1988, *Resolutions of unbounded complexes* (?) [1·B]; `Hassett2000Special` Hassett 2000, *Special cubic fourfolds* (?) [1·C]; `Kottwitz1985Isocrystals` Kottwitz 1985, *Isocrystals with additional structure* (?) [1·C]; `LooijengaPeters1981Torelli` Looijenga–Peters 1981, *Torelli theorems for Kähler K3 surfaces* (?) [1·C]; `Morris1999Level` Morris 1999, *Level zero G-types* (?) [1·C]; `Thomason1997Classification` Thomason 1997, *Classification of triangulated subcategories* (?) [1·C]; `Waldspurger1997Lemme` Waldspurger 1997, *Le lemme fondamental implique le transfert* (?) [1·C]
- *Comment. Math. Helv.* (9): `Beauville1998Fano` Beauville 1998, *Fano contact manifolds and nilpotent orbits* (?) [1·A]; `MoyPrasad1996Jacquet` Moy–Prasad 1996, *Jacquet functors and unrefined minimal K-types* (?) [2·B]; `Adams1958Structure` Adams 1958, *Structure and applications of the Steenrod algebra* (?) [1·B]; `BorelSerre1973Corners` Borel–Serre 1973, *Corners and arithmetic groups* (?) [1·B]; `EckmannMuller1980Poincare` Eckmann–Müller 1980, *Poincaré duality groups of dimension two* (?) [1·B]; `Paris2002Artin` Paris 2002, *Artin monoids inject in their groups* (?) [1·B]; `Serre1953Cohomologie` Serre 1953, *Cohomologie modulo 2 des complexes d'Eilenberg–MacLane* (?) [1·B]; `Thom1954Quelques` Thom 1954, *Quelques propriétés globales des variétés différentiables* [1·B]; `Kervaire1965Theoreme` Kervaire 1965, *Le théorème de Barden–Mazur–Stallings* (?) [1·C]
- *GAFA* (7): `Bourgain1993Fourier` Bourgain 1993, *Fourier transform restriction phenomena for certain lattice…* (?) [2·A]; `HaglundWise2008Special` Haglund–Wise 2008, *Special cube complexes* (?) [1·A]; `Ball1992Markov` Ball 1992, *Markov chains, Riesz transforms and Lipschitz maps* (?) [1·B]; `Luck1994Approximating` Lück 1994, *Approximating L²-invariants by their finite-dimensional…* (?) [1·B]; `Voiculescu1996Analogues` Voiculescu 1996, *Analogues of entropy and of Fisher's information measure in…* (?) [1·B]; `Wenger2005Isoperimetric` Wenger 2005, *Isoperimetric inequalities of Euclidean type in metric…* (?) [1·B]; `Wolff2000Local` Wolff 2000, *Local smoothing type estimates on L^p for large p* (?) [1·B]
- *Israel J. Math.* (5): `Kinnunen1997Hardy` Kinnunen 1997, *Hardy–Littlewood maximal function of a Sobolev function* (?) [1·A]; `MakarLimanov1996Hypersurface` Makar-Limanov 1996, *Hypersurface x + x²y + z² + t³ = 0 in C⁴ or a C³-like…* (?) [1·A]; `HeathBrown2000Kummer` Heath-Brown 2000, *Kummer's conjecture for cubic Gauss sums* (?) [1·B]; `LindenstraussWeiss2000Mean` Lindenstrauss–Weiss 2000, *Mean topological dimension* (?) [1·B]; `KazhdanLusztig1988Fixed` Kazhdan–Lusztig 1988, *Fixed point varieties on affine flag manifolds* (?) [1·C]
- *Arch. Ration. Mech. Anal.* (4): `Ball1977Convexity` Ball 1977, *Convexity conditions and existence theorems in nonlinear…* (?) [1·A]; `Kato1975Cauchy` Kato 1975, *Cauchy problem for quasi-linear symmetric hyperbolic systems* (?) [1·A]; `GlasseyStrauss1986Singularity` Glassey–Strauss 1986, *Singularity formation in a collisionless plasma could occur…* (?) [1·B]; `Jensen1993Uniqueness` Jensen 1993, *Uniqueness of Lipschitz extensions* (?) [1·B]
- *Math. Z.* (4): `Cramer1936Eigenschaft` Cramér 1936, *Über eine Eigenschaft der normalen Verteilungsfunktion* (?) [1·A]; `Huber1994Generalization` Huber 1994, *Generalization of formal schemes and rigid analytic…* [1·A]; `Bruning1978Knoten` Brüning 1978, *Über Knoten von Eigenfunktionen des…* (?) [1·B]; `OhsawaTakegoshi1987Extension` Ohsawa–Takegoshi 1987, *Extension of L² holomorphic functions* (?) [1·B]
- *Comput. Complexity* (3): `MarriottWatrous2005Quantum` Marriott–Watrous 2005, *Quantum Arthur–Merlin games* (?) [1·A]; `NisanSzegedy1994Degree` Nisan–Szegedy 1994, *Degree of Boolean functions as real polynomials* (?) [1·A]; `RazShpilka2005Deterministic` Raz–Shpilka 2005, *Deterministic polynomial identity testing in…* (?) [1·A]
- *Funct. Anal. Appl.* (3): `Beilinson1978Coherent` Beilinson 1978, *Coherent sheaves on P^n and problems of linear algebra* (?) [1·B]; `Bernstein1972Analytic` Bernstein 1972, *Analytic continuation of generalized functions with respect…* (?) [1·B]; `Dobrushin1979Vlasov` Dobrushin 1979, *Vlasov equations* (?) [1·B]
- *Discrete Comput. Geom.* (2): `Dey1998Improved` Dey 1998, *Improved bounds for planar k-sets and related problems* (?) [1·A]; `KannanLovaszSimonovits1995Isoperimetric` Kannan–Lovász–Simonovits 1995, *Isoperimetric problems for convex bodies and a localization…* (?) [1·A]
- *J. Stat. Phys.* (2): `Georgii1995Equivalence` Georgii 1995, *Equivalence of ensembles for classical systems of particles* (?) [1·B]; `Knabe1988Energy` Knabe 1988, *Energy gaps and elementary excitations for certain…* (?) [1·B]
- *Z. Wahrsch. Verw. Gebiete* (2): `DiaconisShahshahani1981Generating` Diaconis–Shahshahani 1981, *Generating a random permutation with random transpositions* (?) [1·A]; `Russo1981Critical` Russo 1981, *Critical percolation probabilities* (?) [1·A]
- *Abh. Math. Sem. Univ. Hamburg* (1): `Sperner1928Neuer` Sperner 1928, *Neuer Beweis für die Invarianz der Dimensionszahl und des…* (?) [1·A]
- *Acta Inform.* (1): `CoffmanGraham1972Optimal` Coffman–Graham 1972, *Optimal scheduling for two-processor systems* (?) [1·B]
- *Acta Sci. Math. (Szeged)* (?) (1): `GratzerSchmidt1963Characterizations` Grätzer–Schmidt 1963, *Characterizations of congruence lattices of abstract…* (?) [1·A]
- *Algebra Universalis* (1): `PalfyPudlak1980Congruence` Pálfy–Pudlák 1980, *Congruence lattices of finite algebras and intervals in…* (?) [1·A]
- *Arch. Math.* (1): `TomDieck1975Orbittypen` tom Dieck 1975, *Orbittypen und äquivariante Homologie II* (?) [1·C]
- *Ark. Mat.* (?) (1): `Ekedahl1984Multiplicative` Ekedahl 1984, *Multiplicative properties of the de Rham–Witt complex I* (?) [1·A]
- *Boll. UMI* (?) (1): `ModicaMortola1977Esempio` Modica–Mortola 1977, *Un esempio di Γ⁻-convergenza* (?) [1·A]
- *Bolyai Soc. Math. Stud.* (1): `HolstLovaszSchrijver1999Colin` van der Holst et al. 1999, *Colin de Verdière graph parameter* (?) [1·B]
- *Calc. Var. PDE* (1): `EvansSavin2008C` Evans–Savin 2008, *C^{1,α} regularity for infinity harmonic functions in two…* (?) [1·B]
- *Computing* (1): `Krawczyk1969Newton` Krawczyk 1969, *Newton-Algorithmen zur Bestimmung von Nullstellen mit…* (?) [1·A]
- *Found. Comput. Math.* (1): `Renegar2006Hyperbolic` Renegar 2006, *Hyperbolic programs, and their derivative relaxations* (?) [1·A]
- *Int. J. Game Theory* (1): `EhrenfeuchtMycielski1979Positional` Ehrenfeucht–Mycielski 1979, *Positional strategies for mean payoff games* (?) [1·A]
- *J. Algebraic Combin.* (1): `LoehrRemmel2011Computational` Loehr–Remmel 2011, *Computational and combinatorial exposé of plethystic…* (?) [1·A]
- *J. Anal. Math.* (1): `FurstenbergKatznelson1985Ergodic` Furstenberg–Katznelson 1985, *Ergodic Szemerédi theorem for IP-systems and combinatorial…* (?) [1·B]
- *J. Soviet Math.* (1): `Beilinson1985Higher` Beilinson 1985, *Higher regulators and values of L-functions* (?) [1·C]
- *K-Theory* (1): `Balmer2000Triangular` Balmer 2000, *Triangular Witt groups. Part I* (?) [1·A]
- *Lett. Math. Phys.* (1): `Araki1990Inequality` Araki 1990, *Inequality of Lieb and Thirring* (?) [1·A]
- *Living Rev. Relativ.* (1): `Minguzzi2019Lorentzian` Minguzzi 2019, *Lorentzian causality theory* (?) [1·B]
- *Manuscripta Math.* (1): `SchoenYau1979Structure` Schoen–Yau 1979, *Structure of manifolds with positive scalar curvature* (?) [1·B]
- *Math. Notes (transl. of Mat. Zametki)* (1): `ZemlyakovKatok1975Topological` Zemlyakov–Katok 1975, *Topological transitivity of billiards in polygons* (?) [1·B]
- *Math. Program.* (1): `Lovasz1983Submodular` Lovász 1983, *Submodular functions and convexity* (?) [1·A]
- *Period. Math. Hungar.* (1): `Billingsley1972Distribution` Billingsley 1972, *Distribution of large prime divisors* [1·A]
- *Probab. Theory Related Fields* (1): `Talagrand2006Free` Talagrand 2006, *Free energy of the spherical mean field model* (?) [1·B]
- *Res. Math. Sci.* (1): `HarrisEtAl2016Rigid` Harris et al. 2016, *Rigid cohomology of certain Shimura varieties* (?) [1·C]
- *Z. Phys.* (1): `Wegner1981Bounds` Wegner 1981, *Bounds on the density of states in disordered systems* (?) [1·C]

**Other (44)**

- `Quillen1973Higher` Quillen 1973, *Higher algebraic K-theory* (?) [4·A] — in Algebraic K-Theory I (Battelle 1972), Lecture Notes in Mathematics 341, Springer, 85–147
- `Bombieri1973Counting` Bombieri 1973, *Counting points on curves over finite fields (d'après S. A…* [3·A] — Séminaire Bourbaki exp. 430 (1972/73), Lecture Notes in Math. 383, 234–241
- `BlochKato1990L` Bloch–Kato 1990, *L-functions and Tamagawa numbers of motives* [2·A] — The Grothendieck Festschrift I, Progr. Math. 86, Birkhäuser, 333-400
- `DeligneRapoport1973Schemas` Deligne–Rapoport 1973, *Les schémas de modules de courbes elliptiques* [2·A] — Modular Functions of One Variable II, Lecture Notes in Mathematics 349, Springer, 143-316
- `Balmer2005Witt` Balmer 2005, *Witt groups* (?) [1·A] — in Handbook of K-Theory, Vol. 2, Springer, 539–576
- `BassTate1973Milnor` Bass–Tate 1973, *Milnor ring of a global field* (?) [1·A] — in Algebraic K-Theory II, Lecture Notes in Mathematics 342, Springer, 349–446
- `DennisStein1973K2` Dennis–Stein 1973, *K₂ of radical ideals and semi-local rings revisited* (?) [1·A] — in Algebraic K-Theory II, Lecture Notes in Mathematics 342, Springer, 281–303
- `Green1998Generic` Green 1998, *Generic initial ideals* (?) [1·A] — Six Lectures on Commutative Algebra, Progress in Mathematics 166, Birkhäuser, 119–186
- `Hagerup1998Sorting` Hagerup 1998, *Sorting and searching on the word RAM* (?) [1·A] — STACS 98, LNCS 1373, Springer, 366–398
- `Hurkens1995Simplification` Hurkens 1995, *Simplification of Girard's paradox* (?) [1·A] — TLCA 1995, LNCS 902, Springer, 266–278
- `Ihara1989Galois` Ihara 1989, *Galois representation arising from P¹ − {0, 1, ∞} and Tate…* (?) [1·A] — Galois Groups over Q, MSRI Publications 16, Springer, 299–313
- `KempfNess1979Length` Kempf–Ness 1979, *Length of vectors in representation spaces* (?) [1·A] — in Algebraic Geometry (Copenhagen 1978), Lecture Notes in Math. 732, Springer, 233–243
- `Kudla2004Tate` Kudla 2004, *Tate's thesis* [1·A] — An Introduction to the Langlands Program, Birkhäuser, 109-131
- `Melquiond2008Proving` Melquiond 2008, *Proving bounds on real-valued functions with computations* (?) [1·A] — Automated Reasoning (IJCAR 2008), LNCS 5195, Springer, 2–17
- `Mestre1991Construction` Mestre 1991, *Construction de courbes de genre 2 à partir de leurs modules* [1·A] — Effective Methods in Algebraic Geometry (MEGA 1990), Progr. Math. 94, Birkhäuser, 313-334
- `Milne1983Action` Milne 1983, *Action of an automorphism of C on a Shimura variety and its…* [1·A] — Arithmetic and Geometry I, Progr. Math. 35, Birkhäuser, 239-265
- `Ribet2004Abelian` Ribet 2004, *Abelian varieties over Q and modular forms* (?) [1·A] — Modular Curves and Abelian Varieties, Progr. Math. 224, Birkhäuser, 241-261 (first published 1992)
- `SerreStark1977Modular` Serre–Stark 1977, *Modular forms of weight 1/2* [1·A] — Modular Functions of One Variable VI, Lecture Notes in Mathematics 627, Springer, 27-67
- `Sturm1987Congruence` Sturm 1987, *Congruence of modular forms* [1·A] — Number Theory (New York 1984-85), Lecture Notes in Mathematics 1240, Springer, 275-280
- `Kolyvagin1990Euler` Kolyvagin 1990, *Euler systems* [3·B] — The Grothendieck Festschrift II, Progr. Math. 87, Birkhäuser, 435-483
- `BousfieldFriedlander1978Homotopy` Bousfield–Friedlander 1978, *Homotopy theory of Γ-spaces, spectra, and bisimplicial sets* (?) [1·B] — in Geometric Applications of Homotopy Theory II, Lecture Notes in Mathematics 658, Springer, 80–130
- `CohenLenstra1984Heuristics` Cohen–Lenstra 1984, *Heuristics on class groups of number fields* (?) [1·B] — Number Theory (Noordwijkerhout 1983), Lecture Notes in Mathematics 1068, Springer, 33-62
- `Deligne1990Categories` Deligne 1990, *Catégories tannakiennes* (?) [1·B] — The Grothendieck Festschrift II, Progress in Mathematics 87, Birkhäuser, 111–195
- `DeligneMilne1982Tannakian` Deligne–Milne 1982, *Tannakian categories* (?) [1·B] — Hodge Cycles, Motives, and Shimura Varieties, Lecture Notes in Mathematics 900, 101–228
- `Edixhoven1991Manin` Edixhoven 1991, *Manin constants of modular elliptic curves* (?) [1·B] — Arithmetic Algebraic Geometry (Texel 1989), Progr. Math. 89, Birkhäuser, 25-39
- `Fontaine1990Representations` Fontaine 1990, *Représentations p-adiques des corps locaux I* (?) [1·B] — The Grothendieck Festschrift II, Progr. Math. 87, Birkhäuser, 249-309
- `Grayson1976Higher` Grayson 1976, *Higher algebraic K-theory* (?) [1·B] — in Algebraic K-Theory (Evanston 1976), Lecture Notes in Mathematics 551, Springer, 217–240
- `GreenGriffiths1980Two` Green–Griffiths 1980, *Two applications of algebraic geometry to entire…* (?) [1·B] — The Chern Symposium 1979, Springer, 41–74
- `Hirzebruch1983Arrangements` Hirzebruch 1983, *Arrangements of lines and algebraic surfaces* (?) [1·B] — in Arithmetic and Geometry II, Progress in Math. 36, Birkhäuser, 113–140
- `Jantzen2004Nilpotent` Jantzen 2004, *Nilpotent orbits in representation theory* (?) [1·B] — Lie Theory: Lie Algebras and Representations, Progress in Mathematics 228, Birkhäuser, 1–211
- `Katz1981Serre` Katz 1981, *Serre–Tate local moduli* (?) [1·B] — in Surfaces Algébriques (Orsay 1976–78), Lecture Notes in Math. 868, Springer, 138–202
- `Kebekus2002Characterizing` Kebekus 2002, *Characterizing the projective space after Cho, Miyaoka and…* (?) [1·B] — in Complex Geometry (Göttingen 2000), Springer, 147–155
- `Mumford1983Towards` Mumford 1983, *Towards an enumerative geometry of the moduli space of…* (?) [1·B] — in Arithmetic and Geometry II, Progress in Math. 36, Birkhäuser, 271–328
- `Raynaud1978Contre` Raynaud 1978, *Contre-exemple au « vanishing theorem » en caractéristique…* (?) [1·B] — in C. P. Ramanujam — A Tribute, TIFR Studies in Math. 8, Springer, 273–278
- `Rordam2002Classification` Rørdam 2002, *Classification of nuclear, simple C*-algebras* (?) [1·B] — in M. Rørdam, E. Størmer, Classification of Nuclear C*-Algebras. Entropy in Operator Algebras, Encyclopaedia o
- `Schaefer2010Complexity` Schaefer 2010, *Complexity of some geometric and topological problems* (?) [1·B] — Graph Drawing (GD 2009), LNCS 5849, Springer, 334–344
- `Schlichting2011Higher` Schlichting 2011, *Higher algebraic K-theory (after Quillen, Thomason and…* (?) [1·B] — in Topics in Algebraic and Topological K-Theory, Lecture Notes in Mathematics 2008, Springer, 167–241
- `Voiculescu1990Circular` Voiculescu 1990, *Circular and semicircular systems and free product factors* (?) [1·B] — in Operator Algebras, Unitary Representations, Enveloping Algebras, and Invariant Theory (Paris, 1989), Progre
- `Zeitouni2004Random` Zeitouni 2004, *Random walks in random environment* (?) [1·B] — Lectures on Probability Theory and Statistics (Saint-Flour 2001), Lecture Notes in Math. 1837, Springer, 189–3
- `Geemen1994Hodge` van Geemen 1994, *Hodge conjecture for abelian varieties* (?) [1·C] — in Algebraic Cycles and Hodge Theory (Torino 1993), Lecture Notes in Math. 1594, Springer
- `KontsevichZagier2001Periods` Kontsevich–Zagier 2001, *Periods* (?) [1·C] — in Mathematics Unlimited — 2001 and Beyond, Springer, 771–808
- `Morel2004Motivic` Morel 2004, *Motivic π₀ of the sphere spectrum* (?) [1·C] — in Axiomatic, Enriched and Motivic Homotopy Theory, NATO Science Series II 131, Kluwer, 219–260
- `SuslinVoevodsky2000Bloch` Suslin–Voevodsky 2000, *Bloch–Kato conjecture and motivic cohomology with finite…* (?) [1·C] — in The Arithmetic and Geometry of Algebraic Cycles (Banff 1998), NATO Science Series C 548, Kluwer, 117–189
- `Zagier1991Polylogarithms` Zagier 1991, *Polylogarithms, Dedekind zeta functions and the algebraic…* (?) [1·C] — Arithmetic Algebraic Geometry (Texel 1989), Progr. Math. 89, Birkhäuser, 391-430

### American Mathematical Society (AMS) — 225

**Books (109)**

- `Koukoulopoulos2019Distribution` Koukoulopoulos 2019, *Distribution of Prime Numbers* [4·A] — Graduate Studies in Mathematics 203
- `DrutuKapovich2018Geometric` Druţu–Kapovich 2018, *Geometric Group Theory* (?) [3·A] — Colloquium Publications 63
- `Jantzen2003Representations` Jantzen 2003, *Representations of Algebraic Groups* (?) [3·A] — Mathematical Surveys and Monographs 107
- `McDuffSalamon2012J` McDuff–Salamon 2012, *J-holomorphic Curves and Symplectic Topology* (?) [3·A] — Colloquium Publications 52
- `Olsson2016Algebraic` Olsson 2016, *Algebraic Spaces and Stacks* [3·A] — Colloquium Publications 62
- `Ahlfors2006Lectures` Ahlfors 2006, *Quasiconformal Mappings* (?) [2·A] — University Lecture Series 38
- `BenyaminiLindenstrauss2000Geometric` Benyamini–Lindenstrauss 2000, *Geometric Nonlinear Functional Analysis, Vol. 1* (?) [2·A] — Colloquium Publications 48
- `BrazitikosEtAl2014Geometry` Brazitikos et al. 2014, *Geometry of Isotropic Convex Bodies* (?) [2·A] — Mathematical Surveys and Monographs 196
- `BrownOzawa2008C` Brown–Ozawa 2008, *C*-Algebras and Finite-Dimensional Approximations* (?) [2·A] — Graduate Studies in Mathematics 88
- `FantechiEtAl2005Fundamental` Fantechi et al. 2005, *Fundamental Algebraic Geometry* [2·A] — Mathematical Surveys and Monographs 123
- `Guth2016Polynomial` Guth 2016, *Polynomial Methods in Combinatorics* (?) [2·A] — University Lecture Series 64
- `LabaShubin2003Lectures` Łaba–Shubin) 2003, *Harmonic Analysis* (?) [2·A] — University Lecture Series 29
- `Lawler2005Conformally` Lawler 2005, *Conformally Invariant Processes in the Plane* (?) [2·A] — Mathematical Surveys and Monographs 114
- `Lovasz2012Large` Lovász 2012, *Large Networks and Graph Limits* (?) [2·A] — Colloquium Publications 60
- `Smith2011Subgroup` Smith 2011, *Subgroup Complexes* (?) [2·A] — Mathematical Surveys and Monographs 179
- `Tao2006Nonlinear` Tao 2006, *Nonlinear Dispersive Equations* (?) [2·A] — CBMS Regional Conference Series in Mathematics 106
- `Wall1999Surgery` Wall 1999, *Surgery on Compact Manifolds* (?) [2·A] — Mathematical Surveys and Monographs 69 (ed. A. Ranicki)
- `AglerMcCarthy2002Pick` Agler–McCarthy 2002, *Pick Interpolation and Hilbert Function Spaces* (?) [1·A] — Graduate Studies in Mathematics 44
- `Ahlfors1973Conformal` Ahlfors 1973, *Conformal Invariants* (?) [1·A] — McGraw-Hill (reprinted Chelsea 2010)
- `AlsinaBayer2004Quaternion` Alsina–Bayer 2004, *Quaternion Orders, Quadratic Forms, and Shimura Curves* [1·A] — CRM Monograph Series 22
- `ArtinTate2009Class` Artin–Tate 2009, *Class Field Theory* [1·A] — Chelsea Publishing
- `ArtsteinAvidanGiannopoulosMilman2015Asymptotic` Artstein-Avidan et al. 2015, *Asymptotic Geometric Analysis, Part I* (?) [1·A] — Mathematical Surveys and Monographs 202
- `BakerRumely2010Potential` Baker–Rumely 2010, *Potential Theory and Dynamics on the Berkovich Projective…* (?) [1·A] — Mathematical Surveys and Monographs 159
- `Berkovich1990Spectral` Berkovich 1990, *Spectral Theory and Analytic Geometry over Non-Archimedean…* (?) [1·A] — Mathematical Surveys and Monographs 33
- `Bogachev1998Gaussian` Bogachev 1998, *Gaussian Measures* (?) [1·A] — Mathematical Surveys and Monographs 62
- `BuragoBuragoIvanov2001Course` Burago–Burago–Ivanov 2001, *Metric Geometry* (?) [1·A] — Graduate Studies in Mathematics 33
- `CheegerEbin1975Comparison` Cheeger–Ebin 1975, *Comparison Theorems in Riemannian Geometry* (?) [1·A] — Mathematical Library 9 (reprinted Chelsea, 2008)
- `Chung1997Spectral` Chung 1997, *Spectral Graph Theory* (?) [1·A] — CBMS Regional Conference Series in Mathematics 92
- `CieliebakEliashberg2012Stein` Cieliebak–Eliashberg 2012, *From Stein to Weinstein and Back* (?) [1·A] — Colloquium Publications 59
- `Conway2000Course` Conway 2000, *Operator Theory* (?) [1·A] — Graduate Studies in Mathematics 21
- `CorneaEtAl2003Lusternik` Cornea et al. 2003, *Lusternik–Schnirelmann Category* (?) [1·A] — Mathematical Surveys and Monographs 103
- `CoxLittleSchenck2011Toric` Cox–Little–Schenck 2011, *Toric Varieties* (?) [1·A] — Graduate Studies in Math. 124
- `Cutkosky2004Resolution` Cutkosky 2004, *Resolution of Singularities* (?) [1·A] — Graduate Studies in Math. 63
- `Davidson1996C` Davidson 1996, *C*-Algebras by Example* (?) [1·A] — Fields Institute Monographs 6
- `Evans2010Partial` Evans 2010, *Partial Differential Equations* (?) [1·A] — Graduate Studies in Mathematics 19
- `FranklTokushige2018Extremal` Frankl–Tokushige 2018, *Extremal Problems for Finite Sets* (?) [1·A] — Student Mathematical Library 86
- `Fresse2017Homotopy` Fresse 2017, *Homotopy of Operads and Grothendieck–Teichmüller Groups…* (?) [1·A] — Mathematical Surveys and Monographs 217
- `Glasner2003Ergodic` Glasner 2003, *Ergodic Theory via Joinings* (?) [1·A] — Mathematical Surveys and Monographs 101
- `Goluzin1969Geometric` Goluzin 1969, *Geometric Theory of Functions of a Complex Variable* (?) [1·A] — Translations of Mathematical Monographs 26
- `GunningRossi1965Analytic` Gunning–Rossi 1965, *Analytic Functions of Several Complex Variables* (?) [1·A] — Prentice-Hall (reprinted Chelsea 2009)
- `Hirschhorn2003Model` Hirschhorn 2003, *Model Categories and Their Localizations* (?) [1·A] — Mathematical Surveys and Monographs 99
- `Hollander2000Large` den Hollander 2000, *Large Deviations* (?) [1·A] — Fields Institute Monographs 14
- `HongKang2002Quantum` Hong–Kang 2002, *Quantum Groups and Crystal Bases* (?) [1·A] — Graduate Studies in Mathematics 42
- `Hovey1999Model` Hovey 1999, *Model Categories* (?) [1·A] — Mathematical Surveys and Monographs 63
- `Ilyashenko1991Finiteness` Ilyashenko 1991, *Finiteness Theorems for Limit Cycles* (?) [1·A] — Translations of Mathematical Monographs 94
- `Isaacs1976Character` Isaacs 1976, *Character Theory of Finite Groups* (?) [1·A] — ( Chelsea reprint 2006)
- `Isaacs2008Finite` Isaacs 2008, *Finite Group Theory* (?) [1·A] — Graduate Studies in Mathematics 92
- `Iwaniec1997Topics` Iwaniec 1997, *Classical Automorphic Forms* [1·A] — Graduate Studies in Mathematics 17
- `Iwaniec2002Spectral` Iwaniec 2002, *Spectral Methods of Automorphic Forms* [1·A] — Graduate Studies in Mathematics 53
- `IyengarEtAl2007Twenty` Iyengar et al. 2007, *Twenty-Four Hours of Local Cohomology* (?) [1·A] — Graduate Studies in Mathematics 87
- `Juschenko2022Amenability` Juschenko 2022, *Amenability of Discrete Groups by Examples* (?) [1·A] — Mathematical Surveys and Monographs 266
- `KadisonRingrose1983Fundamentals` Kadison–Ringrose 1983, *Fundamentals of the Theory of Operator Algebras, Vol. I* (?) [1·A] — reprinted as Graduate Studies in Mathematics 15 (1997)
- `KadisonRingrose1986Fundamentals` Kadison–Ringrose 1986, *Fundamentals of the Theory of Operator Algebras, Vol. II* (?) [1·A] — reprinted as Graduate Studies in Mathematics 16 (1997)
- `Krantz1992Function` Krantz 1992, *Function Theory of Several Complex Variables* (?) [1·A] — Wadsworth & Brooks/Cole (reprinted Chelsea 2001)
- `KrauseLenagan2000Growth` Krause–Lenagan 2000, *Growth of Algebras and Gelfand–Kirillov Dimension* (?) [1·A] — Graduate Studies in Mathematics 22
- `Lam2005Quadratic` Lam 2005, *Quadratic Forms over Fields* [1·A] — Graduate Studies in Mathematics 67
- `Ledoux2001Concentration` Ledoux 2001, *Concentration of Measure Phenomenon* (?) [1·A] — Mathematical Surveys and Monographs 89
- `LeuschkeWiegand2012Cohen` Leuschke–Wiegand 2012, *Cohen–Macaulay Representations* (?) [1·A] — Mathematical Surveys and Monographs 181
- `Loring1997Lifting` Loring 1997, *Lifting Solutions to Perturbing Problems in C*-Algebras* (?) [1·A] — Fields Institute Monographs 8
- `LovaszPlummer1986Matching` Lovász–Plummer 1986, *Matching Theory* (?) [1·A] — Mathematics Studies 121 (Annals of Discrete Mathematics 29); reprinted Chelsea 2009
- `LubotzkyMagid1985Varieties` Lubotzky–Magid 1985, *Varieties of representations of finitely generated groups* (?) [1·A] — Mem. Amer. Math. Soc. 58, no. 336
- `MaclaganSturmfels2015Tropical` Maclagan–Sturmfels 2015, *Tropical Geometry* (?) [1·A] — Graduate Studies in Math. 161
- `Marshall2008Positive` Marshall 2008, *Positive Polynomials and Sums of Squares* (?) [1·A] — Mathematical Surveys and Monographs 146
- `McConnellRobson2001Noncommutative` McConnell–Robson 2001, *Noncommutative Noetherian Rings* (?) [1·A] — Graduate Studies in Mathematics 30 (revised edition of 1987)
- `Nikolski2002Operators` Nikolski 2002, *Operators, Functions, and Systems* (?) [1·A] — Mathematical Surveys and Monographs 92–93
- `Tao2012Higher` Tao 2012, *Higher Order Fourier Analysis* [1·A] — Graduate Studies in Mathematics 142
- `Wise2012Riches` Wise 2012, *From Riches to Raags* (?) [1·A] — CBMS Regional Conference Series in Mathematics 117
- `Ravenel1986Complex` Ravenel 1986, *Complex Cobordism and Stable Homotopy Groups of Spheres* (?) [3·B] — Pure and Applied Mathematics 121 (2nd ed. Chelsea 347, 2004)
- `BorelWallach2000Continuous` Borel–Wallach 2000, *Continuous Cohomology, Discrete Subgroups, and…* (?) [1·B] — Mathematical Surveys and Monographs 67
- `CaffarelliCabre1995Fully` Caffarelli–Cabré 1995, *Fully Nonlinear Elliptic Equations* (?) [1·B] — Colloquium Publications 43
- `CaffarelliSalsa2005Geometric` Caffarelli–Salsa 2005, *Geometric Approach to Free Boundary Problems* (?) [1·B] — Graduate Studies in Mathematics 68
- `ChaiConradOort2014Complex` Chai–Conrad–Oort 2014, *Complex Multiplication and Lifting Problems* (?) [1·B] — Mathematical Surveys and Monographs 195
- `ColdingMinicozzi2011Course` Colding–Minicozzi 2011, *Minimal Surfaces* (?) [1·B] — Graduate Studies in Mathematics 121
- `DamanikFillman2022One` Damanik–Fillman 2022, *One-Dimensional Ergodic Schrödinger Operators I* (?) [1·B] — Graduate Studies in Mathematics 221
- `DavidSemmes1993Analysis` David–Semmes 1993, *Analysis of and on Uniformly Rectifiable Sets* (?) [1·B] — Mathematical Surveys and Monographs 38
- `EliashbergMishachev2002H` Eliashberg–Mishachev 2002, *H-Principle* (?) [1·B] — Graduate Studies in Mathematics 48
- `ElmendorfEtAl1997Rings` Elmendorf et al. 1997, *Rings, Modules, and Algebras in Stable Homotopy Theory* (?) [1·B] — Mathematical Surveys and Monographs 47
- `FrenkelBenZvi2004Vertex` Frenkel–Ben-Zvi 2004, *Vertex Algebras and Algebraic Curves* (?) [1·B] — Mathematical Surveys and Monographs 88
- `HanHong2006Isometric` Han–Hong 2006, *Isometric Embedding of Riemannian Manifolds in Euclidean…* (?) [1·B] — Mathematical Surveys and Monographs 130
- `Helgason1978Differential` Helgason 1978, *Differential Geometry, Lie Groups, and Symmetric Spaces* (?) [1·B] — Pure and Applied Mathematics 80 (reprinted GSM 34, 2001)
- `HostKra2018Nilpotent` Host–Kra 2018, *Nilpotent Structures in Ergodic Theory* (?) [1·B] — Mathematical Surveys and Monographs 236
- `HoveyPalmieriStrickland1997Axiomatic` Hovey–Palmieri–Strickland 1997, *Axiomatic stable homotopy theory* (?) [1·B] — Memoirs of the 128, no. 610
- `Jaco1980Lectures` Jaco 1980, *Three-Manifold Topology* (?) [1·B] — CBMS Regional Conference Series in Mathematics 43
- `JacoShalen1979Seifert` Jaco–Shalen 1979, *Seifert fibered spaces in 3-manifolds* (?) [1·B] — Memoirs of the 21, no. 220
- `Kac1998Vertex` Kac 1998, *Vertex Algebras for Beginners* (?) [1·B] — University Lecture Series 10
- `Kechris2010Global` Kechris 2010, *Global Aspects of Ergodic Group Actions* (?) [1·B] — Mathematical Surveys and Monographs 160
- `Kubilius1964Probabilistic` Kubilius 1964, *Probabilistic Methods in the Theory of Numbers* (?) [1·B] — Translations of Mathematical Monographs 11
- `LiebLoss2001Analysis` Lieb–Loss 2001, *Analysis* (?) [1·B] — Graduate Studies in Mathematics 14
- `MazurRubin2004Kolyvagin` Mazur–Rubin 2004, *Kolyvagin Systems* [1·B] — Mem. Amer. Math. Soc. 168, no. 799
- `Moriwaki2014Arakelov` Moriwaki 2014, *Arakelov Geometry* (?) [1·B] — Translations of Mathematical Monographs 244
- `PetrosyanShahgholianUraltseva2012Regularity` Petrosyan et al. 2012, *Regularity of Free Boundaries in Obstacle-Type Problems* (?) [1·B] — Graduate Studies in Mathematics 136
- `Simon2005Trace` Simon 2005, *Trace Ideals and Their Applications* (?) [1·B] — Mathematical Surveys and Monographs 120
- `Simon2015Operator` Simon 2015, *Operator Theory* (?) [1·B] — —
- `Tabachnikov2005Geometry` Tabachnikov 2005, *Geometry and Billiards* (?) [1·B] — Student Mathematical Library 30
- `Teschl2000Jacobi` Teschl 2000, *Jacobi Operators and Completely Integrable Nonlinear…* (?) [1·B] — Mathematical Surveys and Monographs 72
- `Thiele2006Wave` Thiele 2006, *Wave Packet Analysis* (?) [1·B] — CBMS Regional Conference Series in Mathematics 105
- `VoiculescuDykemaNica1992Free` Voiculescu–Dykema–Nica 1992, *Free Random Variables* (?) [1·B] — CRM Monograph Series 1
- `Arthur2013Endoscopic` Arthur 2013, *Endoscopic Classification of Representations* (?) [2·C] — Colloquium Publications 61
- `Bloch2000Higher` Bloch 2000, *Higher Regulators, Algebraic K-Theory, and Zeta Functions…* [2·C] — CRM Monograph Series 11
- `AizenmanWarzel2015Random` Aizenman–Warzel 2015, *Random Operators* (?) [1·C] — Graduate Studies in Mathematics 168
- `ChowKnopf2004Ricci` Chow–Knopf 2004, *Ricci Flow* (?) [1·C] — Mathematical Surveys and Monographs 110
- `CoxKatz1999Mirror` Cox–Katz 1999, *Mirror Symmetry and Algebraic Geometry* (?) [1·C] — Mathematical Surveys and Monographs 68
- `GompfStipsicz1999Manifolds` Gompf–Stipsicz 1999, *4-Manifolds and Kirby Calculus* (?) [1·C] — Graduate Studies in Mathematics 20
- `GreenleesMay1995Generalized` Greenlees–May 1995, *Generalized Tate cohomology* (?) [1·C] — Memoirs of the 113, no. 543
- `HoveyStrickland1999Morava` Hovey–Strickland 1999, *Morava K-theories and localisation* (?) [1·C] — Memoirs of the 139, no. 666
- `MandellMay2002Equivariant` Mandell–May 2002, *Equivariant orthogonal spectra and S-modules* (?) [1·C] — Memoirs of the 159, no. 755
- `MurreNagelPeters2013Lectures` Murre–Nagel–Peters 2013, *Theory of Pure Motives* (?) [1·C] — University Lecture Series 61
- `Silverman2012Moduli` Silverman 2012, *Moduli Spaces and Arithmetic Dynamics* (?) [1·C] — CRM Monograph Series 30
- `Szekelyhidi2014Extremal` Székelyhidi 2014, *Extremal Kähler Metrics* (?) [1·C] — Graduate Studies in Mathematics 152

**Journal papers (78)**

- *J. Amer. Math. Soc.* (25): `Friedgut1999Sharp` Friedgut 1999, *Sharp thresholds of graph properties, and the k-sat problem* (?) [2·A]; `BestvinaMess1991Boundary` Bestvina–Mess 1991, *Boundary of negatively curved groups* (?) [1·A]; `Bowditch1998Topological` Bowditch 1998, *Topological characterisation of hyperbolic groups* (?) [1·A]; `CattaniDeligneKaplan1995Locus` Cattani–Deligne–Kaplan 1995, *Locus of Hodge classes* (?) [1·A]; `FranklRodl1990Partition` Frankl–Rödl 1990, *Partition property of simplices in Euclidean space* (?) [1·A]; `Guth2016Restriction` Guth 2016, *Restriction estimate using polynomial partitioning* (?) [1·A]; `Lusztig1989Affine` Lusztig 1989, *Affine Hecke algebras and their graded version* (?) [1·A]; `Neeman1996Grothendieck` Neeman 1996, *Grothendieck duality theorem via Bousfield's techniques and…* (?) [1·A]; `Schmidt1999Cyclotomic` Schmidt 1999, *Cyclotomic integers and finite geometry* (?) [1·A]; `Shelah1988Primitive` Shelah 1988, *Primitive recursive bounds for van der Waerden numbers* (?) [1·A]; `ShestakovUmirbaev2004Tame` Shestakov–Umirbaev 2004, *Tame and the wild automorphisms of polynomial rings in…* (?) [1·A]; `Thomas2003Classification` Thomas 2003, *Classification problem for torsion-free abelian groups of…* (?) [1·A]; `Kisin2008Potentially` Kisin 2008, *Potentially semi-stable deformation rings* [2·B]; `AmbrosioCabre2000Entire` Ambrosio–Cabré 2000, *Entire solutions of semilinear elliptic equations in ℝ³ and…* (?) [1·B]; `BergelsonLeibman1996Polynomial` Bergelson–Leibman 1996, *Polynomial extensions of van der Waerden's and Szemerédi's…* (?) [1·B]; `CharneyDavis1995K` Charney–Davis 1995, *K(π,1)-problem for hyperplane complements associated to…* (?) [1·B]; `Gromov1989Oka` Gromov 1989, *Oka's principle for holomorphic sections of elliptic bundles* (?) [1·B]; `McDuff1990Structure` McDuff 1990, *Structure of rational and ruled symplectic 4-manifolds* (?) [1·B]; `Zhang1995Positive` Zhang 1995, *Positive line bundles on arithmetic varieties* (?) [1·B]; `Zhu1996Modular` Zhu 1996, *Modular invariance of characters of vertex operator algebras* (?) [1·B]; `Kim2007Supercuspidal` Kim 2007, *Supercuspidal representations* (?) [1·C]; `Kisin2009Fontaine` Kisin 2009, *Fontaine-Mazur conjecture for GL_2* (?) [1·C]; `Mori1988Flip` Mori 1988, *Flip theorem and the existence of minimal models for 3-folds* (?) [1·C]; `RognesWeibel2000Two` Rognes–Weibel 2000, *Two-primary algebraic K-theory of rings of integers in…* (?) [1·C]; `Yu2001Construction` Yu 2001, *Construction of tame supercuspidal representations* (?) [1·C]
- *Trans. Amer. Math. Soc.* (25): `Garsia1962Arithmetic` Garsia 1962, *Arithmetic properties of Bernoulli convolutions* (?) [2·A]; `Schlessinger1968Functors` Schlessinger 1968, *Functors of Artin rings* [2·A]; `Anderson1979Extensions` Anderson 1979, *Extensions, restrictions, and representations of states on…* (?) [1·A]; `EnglerKoenigsmann1998Abelian` Engler–Koenigsmann 1998, *Abelian subgroups of pro-p Galois groups* [1·A]; `Hochster1969Prime` Hochster 1969, *Prime ideal structure in commutative rings* (?) [1·A]; `James1964Weakly` James 1964, *Weakly compact sets* (?) [1·A]; `JockuschSoare1972Classes` Jockusch–Soare 1972, *Π⁰₁ classes and degrees of theories* (?) [1·A]; `JonesSeegerWright2008Strong` Jones–Seeger–Wright 2008, *Strong variational and jump inequalities in harmonic…* (?) [1·A]; `Kesten1959Symmetric` Kesten 1959, *Symmetric random walks on groups* (?) [1·A]; `KrohnRhodes1965Algebraic` Krohn–Rhodes 1965, *Algebraic theory of machines. I. Prime decomposition…* (?) [1·A]; `Spencer1985Six` Spencer 1985, *Six standard deviations suffice* (?) [1·A]; `Stembridge2003Local` Stembridge 2003, *Local characterization of simply-laced crystals* (?) [1·A]; `Weil1952Jacobi` Weil 1952, *Jacobi sums as "Grössencharaktere"* [1·A]; `Brody1978Compact` Brody 1978, *Compact manifolds and hyperbolicity* (?) [1·B]; `BrumerKramer2014Paramodular` Brumer–Kramer 2014, *Paramodular abelian varieties of odd conductor* (?) [1·B]; `CrandallLions1983Viscosity` Crandall–Lions 1983, *Viscosity solutions of Hamilton–Jacobi equations* (?) [1·B]; `Green1955Characters` Green 1955, *Characters of the finite general linear groups* (?) [1·B]; `Greene1987Hypergeometric` Greene 1987, *Hypergeometric functions over finite fields* [1·B]; `KadetsEtAl2000Banach` Kadets et al. 2000, *Banach spaces with the Daugavet property* (?) [1·B]; `Keel1992Intersection` Keel 1992, *Intersection theory of moduli space of stable n-pointed…* (?) [1·B]; `Morgan2003Regularity` Morgan 2003, *Regularity of isoperimetric hypersurfaces in Riemannian…* (?) [1·B]; `Swan1962Vector` Swan 1962, *Vector bundles and projective modules* (?) [1·B]; `TomsWinter2007Strongly` Toms–Winter 2007, *Strongly self-absorbing C*-algebras* (?) [1·B]; `HochschildKostantRosenberg1962Differential` Hochschild–Kostant–Rosenberg 1962, *Differential forms on regular affine algebras* (?) [1·C]; `Landman1973Picard` Landman 1973, *Picard–Lefschetz transformation for algebraic manifolds…* (?) [1·C]
- *Bull. Amer. Math. Soc.* (10): `Milnor1966Whitehead` Milnor 1966, *Whitehead torsion* (?) [2·A]; `GabberKac1981Defining` Gabber–Kac 1981, *Defining relations of certain infinite-dimensional Lie…* (?) [1·A]; `HooryLinialWigderson2006Expander` Hoory–Linial–Wigderson 2006, *Expander graphs and their applications* (?) [1·A]; `KahnKalai1993Counterexample` Kahn–Kalai 1993, *Counterexample to Borsuk's conjecture* (?) [1·A]; `Wagner2011Multivariate` Wagner 2011, *Multivariate stable polynomials* (?) [1·A]; `CrandallIshiiLions1992User` Crandall–Ishii–Lions 1992, *User's guide to viscosity solutions of second order partial…* (?) [1·B]; `Kuchment2016Overview` Kuchment 2016, *Overview of periodic elliptic operators* (?) [1·B]; `LellisSzekelyhidi2017High` De Lellis–Székelyhidi 2017, *High dimensionality and h-principle in PDE* (?) [1·B]; `Simon1982Schrodinger` Simon 1982, *Schrödinger semigroups* (?) [1·B]; `Quillen1969Formal` Quillen 1969, *Formal group laws of unoriented and complex cobordism theory* (?) [1·C]
- *Proc. Amer. Math. Soc.* (5): `FriedgutKalai1996Every` Friedgut–Kalai 1996, *Every monotone graph property has a sharp threshold* (?) [1·A]; `Hsu1996Identifying` Hsu 1996, *Identifying congruence subgroups of the modular group* [1·A]; `Kriz1991Permutation` Kříž 1991, *Permutation groups in Euclidean Ramsey theory* (?) [1·A]; `Urbano1990Minimal` Urbano 1990, *Minimal surfaces with low index in the three-dimensional…* (?) [1·B]; `Taguchi1995Tate` Taguchi 1995, *Tate conjecture for t-motives* (?) [1·C]
- *J. Algebraic Geom.* (?) (3): `ArbarelloCornalba1996Combinatorial` Arbarello–Cornalba 1996, *Combinatorial and algebro-geometric cohomology classes on…* (?) [1·B]; `KollarMiyaokaMori1992Rationally` Kollár–Miyaoka–Mori 1992, *Rationally connected varieties* (?) [1·B]; `Zhang1995Small` Zhang 1995, *Small points and adelic metrics* (?) [1·B]
- *Math. Comp.* (3): `Bach1990Explicit` Bach 1990, *Explicit bounds for primality testing and related problems* [1·A]; `Bareiss1968Sylvester` Bareiss 1968, *Sylvester's identity and multistep integer-preserving…* (?) [1·B]; `PoorYuen2015Paramodular` Poor–Yuen 2015, *Paramodular cusp forms* (?) [1·B]
- *Amer. Math. Soc. Transl.* (2): `Rokhlin1962Fundamental` Rokhlin 1962, *Fundamental ideas of measure theory* (?) [1·A]; `Pontryagin1959Smooth` Pontryagin 1959, *Smooth manifolds and their applications in homotopy theory* (?) [1·B]
- *Represent. Theory* (2): `Soergel1997Kazhdan` Soergel 1997, *Kazhdan–Lusztig polynomials and a combinatoric for tilting…* (?) [2·A]; `EliasWilliamson2016Soergel` Elias–Williamson 2016, *Soergel calculus* (?) [1·C]
- *Leningrad / St. Petersburg Math. J.* (1): `Drinfeld1991Quasitriangular` Drinfeld 1991, *Quasitriangular quasi-Hopf algebras and on a group that is…* (?) [1·A]
- *Proc. St. Petersburg Math. Soc.* (1): `FukayaKato2006Formulation` Fukaya–Kato 2006, *Formulation of conjectures on p-adic zeta functions in…* (?) [1·C]
- *Soviet Math. Dokl.* (1): `Bregman1973Properties` Brégman 1973, *Some properties of nonnegative matrices and their permanents* (?) [1·A]

**Other (38)**

- `Deligne1979Varietes` Deligne 1979, *Variétés de Shimura* [4·A] — Automorphic Forms, Representations and L-functions (Corvallis), Proc. Sympos. Pure Math. 33, part 2, AMS, 247-
- `Alperin1987Weights` Alperin 1987, *Weights for finite groups* (?) [1·A] — Proceedings of Symposia in Pure Mathematics 47 (Part 1), AMS, 369–379
- `AtkinSwinnertonDyer1971Modular` Atkin–Swinnerton-Dyer 1971, *Modular forms on noncongruence subgroups* [1·A] — Combinatorics, Proc. Sympos. Pure Math. 19, AMS, 1-25
- `Cartier1979Representations` Cartier 1979, *Representations of p-adic groups* (?) [1·A] — Automorphic Forms, Representations and L-functions (Corvallis), Proc. Sympos. Pure Math. 33 Part 1, AMS, 111–1
- `Chevalley1994Decompositions` Chevalley 1994, *Sur les décompositions cellulaires des espaces G/B* (?) [1·A] — in Algebraic Groups and their Generalizations, Proc. Sympos. Pure Math. 56, Part 1, 1–23
- `Gessel1984Multipartite` Gessel 1984, *Multipartite P-partitions and inner products of skew Schur…* (?) [1·A] — in Combinatorics and Algebra, Contemp. Math. 34, AMS, 289–317
- `IgusaTodorov2005Finitistic` Igusa–Todorov 2005, *Finitistic global dimension conjecture for artin algebras* (?) [1·A] — Representations of Algebras and Related Topics, Fields Institute Communications 45, 201–204
- `Klainerman1986Null` Klainerman 1986, *Null condition and global existence to nonlinear wave…* (?) [1·A] — Nonlinear Systems of PDE in Applied Mathematics, Part 1, Lectures in Applied Mathematics 23, AMS, 293–326
- `Kneser1966Strong` Kneser 1966, *Strong approximation* [1·A] — Algebraic Groups and Discontinuous Subgroups, Proc. Sympos. Pure Math. 9, AMS, 187-196
- `Mumford1966Families` Mumford 1966, *Families of abelian varieties* (?) [1·A] — in Algebraic Groups and Discontinuous Subgroups, Proc. Sympos. Pure Math. 9, 347–351
- `Sageev2014CAT` Sageev 2014, *CAT(0) cube complexes and groups* (?) [1·A] — Geometric Group Theory, IAS/Park City Mathematics Series 21, AMS, 7–54
- `Selberg1965Estimation` Selberg 1965, *Estimation of Fourier coefficients of modular forms* [1·A] — Theory of Numbers, Proc. Sympos. Pure Math. 8, AMS, 1-15
- `Shields1974Weighted` Shields 1974, *Weighted shift operators and analytic function theory* (?) [1·A] — in Topics in Operator Theory, Mathematical Surveys 13, AMS, 49–128
- `Wolff1999Recent` Wolff 1999, *Recent work connected with the Kakeya problem* (?) [1·A] — Prospects in Mathematics (Princeton, 1996), AMS, 129–162
- `AtiyahHirzebruch1961Vector` Atiyah–Hirzebruch 1961, *Vector bundles and homogeneous spaces* (?) [1·B] — in Differential Geometry, Proceedings of Symposia in Pure Mathematics 3, American Mathematical Society, 7–38
- `BaumConnesHigson1994Classifying` Baum–Connes–Higson 1994, *Classifying space for proper actions and K-theory of group…* (?) [1·B] — in C*-Algebras: 1943–1993 (San Antonio, 1993), Contemporary Mathematics 167, AMS, 240–291
- `BorelJacquet1979Automorphic` Borel–Jacquet 1979, *Automorphic forms and automorphic representations* (?) [1·B] — Automorphic Forms, Representations and L-functions (Corvallis), Proc. Sympos. Pure Math. 33, part 1, AMS, 189-
- `CaffarelliJerisonKenig2004Global` Caffarelli–Jerison–Kenig 2004, *Global energy minimizers for free boundary problems and…* (?) [1·B] — Noncompact Problems at the Intersection of Geometry, Analysis, and Topology, Contemporary Mathematics 350, AMS
- `Deligne1987Determinant` Deligne 1987, *Le déterminant de la cohomologie* (?) [1·B] — Current Trends in Arithmetical Algebraic Geometry, Contemp. Math. 67, AMS, 93-177
- `Illusie2002Frobenius` Illusie 2002, *Frobenius and Hodge degeneration* (?) [1·B] — in J. Bertin, J.-P. Demailly, L. Illusie, C. Peters, Introduction to Hodge Theory, SMF/AMS Texts and Monograph
- `Jacquet2009Archimedean` Jacquet 2009, *Archimedean Rankin-Selberg integrals* (?) [1·B] — Automorphic Forms and L-functions II, Contemp. Math. 489, AMS, 57-172
- `Langlands1966Volume` Langlands 1966, *Volume of the fundamental domain for some arithmetical…* (?) [1·B] — Algebraic Groups and Discontinuous Subgroups, Proc. Sympos. Pure Math. 9, AMS, 143-148
- `Langlands1979Notion` Langlands 1979, *Notion of an automorphic representation* (?) [1·B] — Proc. Sympos. Pure Math. 33, part 1, AMS, 203-207
- `Lusztig1980Problems` Lusztig 1980, *Some problems in the representation theory of finite…* (?) [1·B] — Proceedings of Symposia in Pure Mathematics 37, AMS, 313–317
- `Rohrlich1994Elliptic` Rohrlich 1994, *Elliptic curves and the Weil-Deligne group* (?) [1·B] — Elliptic Curves and Related Topics, CRM Proc. Lecture Notes 4, AMS, 125-157
- `Ros2005Isoperimetric` Ros 2005, *Isoperimetric problem* (?) [1·B] — Global Theory of Minimal Surfaces, Clay Mathematics Proceedings 2, AMS, 175–209
- `Simon1995Spectral` Simon 1995, *Spectral analysis of rank one perturbations and applications* (?) [1·B] — in Mathematical Quantum Theory II: Schrödinger Operators (Vancouver, 1993), CRM Proceedings and Lecture Notes 
- `Speicher1998Combinatorial` Speicher 1998, *Combinatorial theory of the free product with amalgamation…* (?) [1·B] — Memoirs of the American Mathematical Society 132, no. 627
- `Tate1979Number` Tate 1979, *Number theoretic background* (?) [1·B] — Automorphic Forms, Representations and L-functions (Corvallis), Proc. Sympos. Pure Math. 33, part 2, AMS, 3-26
- `Tits1966Classification` Tits 1966, *Classification of algebraic semisimple groups* (?) [1·B] — in Algebraic Groups and Discontinuous Subgroups, Proc. Sympos. Pure Math. 9, 33–62
- `WaterhouseMilne1971Abelian` Waterhouse–Milne 1971, *Abelian varieties over finite fields* [1·B] — Proc. Sympos. Pure Math. 20, AMS, 53-64
- `Beilinson1986Higher` Beilinson 1986, *Higher regulators of modular curves* (?) [1·C] — Applications of Algebraic K-theory to Algebraic Geometry and Number Theory, Contemp. Math. 55, AMS, 1-34
- `Deligne1979Valeurs` Deligne 1979, *Valeurs de fonctions L et périodes d'intégrales* (?) [1·C] — Automorphic Forms, Representations and L-functions (Corvallis), Proc. Sympos. Pure Math. 33, part 2, AMS, 313-
- `Deligne2006Hodge` Deligne 2006, *Hodge conjecture* (?) [1·C] — in The Millennium Prize Problems, Clay Math. Inst./AMS, 45–53
- `EinsiedlerLindenstrauss2010Diagonal` Einsiedler–Lindenstrauss 2010, *Diagonal actions on locally homogeneous spaces* (?) [1·C] — Homogeneous Flows, Moduli Spaces and Arithmetic, Clay Math. Proc. 10, American Mathematical Society, 155–241
- `JacquetRallis2011Gross` Jacquet–Rallis 2011, *Gross-Prasad conjecture for unitary groups* (?) [1·C] — On Certain L-functions, Clay Math. Proc. 13, AMS, 205-264
- `Mandell2004Equivariant` Mandell 2004, *Equivariant symmetric spectra* (?) [1·C] — in Homotopy Theory: Relations with Algebraic Geometry, Group Cohomology, and Algebraic K-Theory, Contemporary 
- `Weibel1989Homotopy` Weibel 1989, *Homotopy algebraic K-theory* (?) [1·C] — in Algebraic K-Theory and Algebraic Number Theory (Honolulu 1987), Contemporary Mathematics 83, American Mathe

### Elsevier (Academic Press, Gauthier-Villars, North-Holland, Pergamon) — 177

**Books (25)**

- `PlatonovRapinchuk1994Algebraic` Platonov–Rapinchuk 1994, *Algebraic Groups and Number Theory* [5·A] — Pure and Applied Mathematics 139
- `Hormander1990Complex` Hörmander 1990, *Complex Analysis in Several Variables* (?) [2·A] — Mathematical Library 7
- `Barwise1977Handbook` Barwise 1977, *Handbook of Mathematical Logic* (?) [1·A] — Studies in Logic and the Foundations of Mathematics 90
- `CasselsFrohlich1967Algebraic` Cassels–Fröhlich 1967, *Algebraic Number Theory* [1·A] — (2nd ed. London Mathematical Society 2010)
- `Ciarlet1988Mathematical` Ciarlet 1988, *Mathematical Elasticity, Vol. I* (?) [1·A] — Studies in Mathematics and its Applications 20
- `DeuschelStroock1989Large` Deuschel–Stroock 1989, *Large Deviations* (?) [1·A] — Pure and Applied Mathematics 137
- `Duren1970Theory` Duren 1970, *Theory of H^p Spaces* (?) [1·A] — Pure and Applied Mathematics 38
- `Fujishige2005Submodular` Fujishige 2005, *Submodular Functions and Optimization* (?) [1·A] — Annals of Discrete Mathematics 58
- `Hazewinkel1978Formal` Hazewinkel 1978, *Formal Groups and Applications* [1·A] — Pure and Applied Mathematics 78 ( Chelsea reprint 2012)
- `HiltonMislinRoitberg1975Localization` Hilton–Mislin–Roitberg 1975, *Localization of Nilpotent Groups and Spaces* (?) [1·A] — Mathematics Studies 15
- `JohnsonLindenstrauss2001Handbook` Johnson–Lindenstrauss 2001, *Handbook of the Geometry of Banach Spaces, Vols. 1–2* (?) [1·A] — (vol. 2: 2003)
- `Newman1972Integral` Newman 1972, *Integral Matrices* (?) [1·A] — Pure and Applied Mathematics 45
- `Olver1974Asymptotics` Olver 1974, *Asymptotics and Special Functions* (?) [1·A] — (A K Peters reprint 1997)
- `Rowen1980Polynomial` Rowen 1980, *Polynomial Identities in Ring Theory* (?) [1·A] — Pure and Applied Mathematics 84
- `Shalit1987Iwasawa` de Shalit 1987, *Iwasawa Theory of Elliptic Curves with Complex…* [1·A] — Perspectives in Mathematics 3
- `ReedSimon1978Methods` Reed–Simon 1978, *Methods of Modern Mathematical Physics IV* (?) [4·B] — —
- `ReedSimon1975Methods` Reed–Simon 1975, *Methods of Modern Mathematical Physics II* (?) [3·B] — —
- `FrenkelLepowskyMeurman1988Vertex` Frenkel–Lepowsky–Meurman 1988, *Vertex Operator Algebras and the Monster* (?) [2·B] — Pure and Applied Mathematics 134
- `ReedSimon1979Methods` Reed–Simon 1979, *Methods of Modern Mathematical Physics III* (?) [2·B] — —
- `Baxter1982Exactly` Baxter 1982, *Exactly Solved Models in Statistical Mechanics* (?) [1·B] — —
- `Borel1987Algebraic` Borel 1987, *Algebraic D-Modules* (?) [1·B] — Perspectives in Math. 2
- `Bredon1972Compact` Bredon 1972, *Compact Transformation Groups* (?) [1·B] — Pure and Applied Mathematics 46
- `Chavel1984Eigenvalues` Chavel 1984, *Eigenvalues in Riemannian Geometry* (?) [1·B] — Pure and Applied Mathematics 115
- `ONeill1983Semi` O'Neill 1983, *Semi-Riemannian Geometry with Applications to Relativity* (?) [1·B] — Pure and Applied Mathematics 103
- `ReedSimon1980Methods` Reed–Simon 1980, *Methods of Modern Mathematical Physics I* (?) [1·B] — —

**Journal papers (142)**

- *J. Combin. Theory* (20): `ChudnovskySeymour2007Roots` Chudnovsky–Seymour 2007, *Roots of the independence polynomial of a clawfree graph* (?) [1·A]; `ChungEtAl1986Intersection` Chung et al. 1986, *Some intersection theorems for ordered sets and graphs* (?) [1·A]; `ChvatalEtAl1983Ramsey` Chvátal et al. 1983, *Ramsey number of a graph with bounded maximum degree* (?) [1·A]; `ClementsLindstrom1969Generalization` Clements–Lindström 1969, *Generalization of a combinatorial theorem of Macaulay* (?) [1·A]; `ErdosEtAl1973Euclidean` Erdős et al. 1973, *Euclidean Ramsey theorems I* (?) [1·A]; `FreundTodd1981Constructive` Freund–Todd 1981, *Constructive proof of Tucker's combinatorial lemma* (?) [1·A]; `Galvin1995List` Galvin 1995, *List chromatic index of a bipartite multigraph* (?) [1·A]; `GarsiaMilne1981Rogers` Garsia–Milne 1981, *Rogers–Ramanujan bijection* (?) [1·A]; `GreeneKleitman1976Structure` Greene–Kleitman 1976, *Structure of Sperner k-families* (?) [1·A]; `Haussler1995Sphere` Haussler 1995, *Sphere packing numbers for subsets of the Boolean n-cube…* (?) [1·A]; `Kleitman1966Combinatorial` Kleitman 1966, *Combinatorial conjecture of Erdős* (?) [1·A]; `Lovasz1978Kneser` Lovász 1978, *Kneser's conjecture, chromatic number, and homotopy* (?) [1·A]; `MarcusTardos2004Excluded` Marcus–Tardos 2004, *Excluded permutation matrices and the Stanley–Wilf…* (?) [1·A]; `Radhakrishnan1997Entropy` Radhakrishnan 1997, *Entropy proof of Bregman's theorem* (?) [1·A]; `Schrijver1998Counting` Schrijver 1998, *Counting 1-factors in regular bipartite graphs* (?) [1·A]; `Thomassen1994Every` Thomassen 1994, *Every planar graph is 5-choosable* (?) [1·A]; `Thomassen2003Short` Thomassen 2003, *Short list color proof of Grötzsch's theorem* (?) [1·A]; `Kleitman1970Crossing` Kleitman 1970, *Crossing number of K_{5,n}* (?) [1·B]; `RobertsonSeymour1986Graph` Robertson–Seymour 1986, *Graph minors. V. Excluding a planar graph* (?) [1·B]; `SeymourThomas1993Graph` Seymour–Thomas 1993, *Graph searching and a min-max theorem for tree-width* (?) [1·B]
- *Adv. Math.* (18): `AuslanderReiten1991Applications` Auslander–Reiten 1991, *Applications of contravariantly finite subcategories* (?) [1·A]; `BakerNorine2007Riemann` Baker–Norine 2007, *Riemann–Roch and Abel–Jacobi theory on a finite graph* (?) [1·A]; `BoroczkyEtAl2012Log` Böröczky et al. 2012, *Log-Brunn–Minkowski inequality* (?) [1·A]; `Forman1998Morse` Forman 1998, *Morse theory for cell complexes* (?) [1·A]; `GesselViennot1985Binomial` Gessel–Viennot 1985, *Binomial determinants, paths, and hook length formulae* (?) [1·A]; `Lieb1973Convex` Lieb 1973, *Convex trace functions and the Wigner–Yanase–Dyson…* (?) [1·A]; `Milnor1976Curvatures` Milnor 1976, *Curvatures of left invariant metrics on Lie groups* (?) [1·A]; `Procesi1976Invariant` Procesi 1976, *Invariant theory of n×n matrices* (?) [1·A]; `Quillen1978Homotopy` Quillen 1978, *Homotopy properties of the poset of nontrivial p-subgroups…* (?) [1·A]; `Seshadri1977Geometric` Seshadri 1977, *Geometric reductivity over arbitrary base* (?) [1·A]; `Stanley1995Symmetric` Stanley 1995, *Symmetric function generalization of the chromatic…* (?) [1·A]; `AraMaltsiniotis2014Vers` Ara–Maltsiniotis 2014, *Vers une structure de catégorie de modèles à la Thomason…* (?) [1·B]; `KirchbergRordam2002Infinite` Kirchberg–Rørdam 2002, *Infinite non-simple C*-algebras* (?) [1·B]; `LafontMetayerWorytkiewicz2010Folk` Lafont–Métayer–Worytkiewicz 2010, *Folk model structure on omega-cat* (?) [1·B]; `WinterZacharias2010Nuclear` Winter–Zacharias 2010, *Nuclear dimension of C*-algebras* (?) [1·B]; `Bloch1986Algebraic` Bloch 1986, *Algebraic cycles and higher K-theory* (?) [2·C]; `Klein1998Extended` Klein 1998, *Extended states in the Anderson model on the Bethe lattice* (?) [1·C]; `WangZhu2004Kahler` Wang–Zhu 2004, *Kähler–Ricci solitons on toric manifolds with positive…* (?) [1·C]
- *Topology* (17): `Peixoto1962Structural` Peixoto 1962, *Structural stability on two-dimensional manifolds* (?) [1·A]; `Wall1963Quadratic` Wall 1963, *Quadratic forms on finite groups, and related topics* [1·A]; `Adams1963Groups` Adams 1963, *Groups J(X) I–IV* (?) [1·B]; `AtiyahBott1984Moment` Atiyah–Bott 1984, *Moment map and equivariant cohomology* (?) [1·B]; `AtiyahBottShapiro1964Clifford` Atiyah–Bott–Shapiro 1964, *Clifford modules* (?) [1·B]; `Bousfield1979Localization` Bousfield 1979, *Localization of spectra with respect to homology* (?) [1·B]; `CheegerGromov1986L` Cheeger–Gromov 1986, *L_2-cohomology and group cohomology* (?) [1·B]; `HatcherThurston1980Presentation` Hatcher–Thurston 1980, *Presentation for the mapping class group of a closed…* (?) [1·B]; `Quillen1971Adams` Quillen 1971, *Adams conjecture* (?) [1·B]; `Segal1974Categories` Segal 1974, *Categories and cohomology theories* (?) [1·B]; `BrownPeterson1966Spectrum` Brown–Peterson 1966, *Spectrum whose Z_p cohomology is the algebra of reduced…* (?) [1·C]; `DevinatzHopkins2004Homotopy` Devinatz–Hopkins 2004, *Homotopy fixed point spectra for closed subgroups of the…* (?) [1·C]; `Donaldson1990Polynomial` Donaldson 1990, *Polynomial invariants for smooth four-manifolds* (?) [1·C]; `Goodwillie1985Cyclic` Goodwillie 1985, *Cyclic homology, derivations, and the free loopspace* (?) [1·C]; `HesselholtMadsen1997K` Hesselholt–Madsen 1997, *K-theory of finite algebras over Witt vectors of perfect…* (?) [1·C]; `Matsushita1999Fibre` Matsushita 1999, *Fibre space structures of a projective irreducible…* (?) [1·C]; `Spivak1967Spaces` Spivak 1967, *Spaces satisfying Poincaré duality* (?) [1·C]
- *Ann. Sci. ENS* (?) (12): `Demazure1970Sous` Demazure 1970, *Sous-groupes algébriques de rang maximum du groupe de…* (?) [1·A]; `Matsumoto1969Sous` Matsumoto 1969, *Sur les sous-groupes arithmétiques des groupes semi-simples…* (?) [1·A]; `DeligneSerre1974Formes` Deligne–Serre 1974, *Formes modulaires de poids 1* (?) [2·B]; `Franke1998Harmonic` Franke 1998, *Harmonic analysis in weighted L2-spaces* (?) [2·B]; `Campana1992Connexite` Campana 1992, *Connexité rationnelle des variétés de Fano* (?) [1·B]; `Mathieu1990Filtrations` Mathieu 1990, *Filtrations of G-modules* (?) [1·B]; `Waterhouse1969Abelian` Waterhouse 1969, *Abelian varieties over finite fields* [1·B]; `Borel1974Stable` Borel 1974, *Stable real cohomology of arithmetic groups* (?) [1·C]; `BurnsRapoport1975Torelli` Burns–Rapoport 1975, *Torelli problem for kählerian K-3 surfaces* (?) [1·C]; `Carayol1986Representations` Carayol 1986, *Sur les représentations l-adiques associées aux formes…* [1·C]; `FriedlanderSuslin2002Spectral` Friedlander–Suslin 2002, *Spectral sequence relating algebraic K-theory to motivic…* (?) [1·C]; `MoretBailly1989Groupes` Moret-Bailly 1989, *Groupes de Picard et problèmes de Skolem II* (?) [1·C]
- *J. Comput. System Sci.* (11): `Ambainis2002Quantum` Ambainis 2002, *Quantum lower bounds by quantum arguments* (?) [1·A]; `CookReckhow1973Time` Cook–Reckhow 1973, *Time bounded random access machines* (?) [1·A]; `FakcharoenpholRaoTalwar2004Tight` Fakcharoenphol–Rao–Talwar 2004, *Tight bound on approximating arbitrary metrics by tree…* (?) [1·A]; `Yannakakis1991Expressing` Yannakakis 1991, *Expressing combinatorial optimization problems by linear…* (?) [1·A]; `ImpagliazzoPaturi2001Complexity` Impagliazzo–Paturi 2001, *Complexity of k-SAT* (?) [1·B]; `ImpagliazzoPaturiZane2001Which` Impagliazzo–Paturi–Zane 2001, *Which problems have strongly exponential complexity?* (?) [1·B]; `JohnsonPapadimitriouYannakakis1988How` Johnson et al. 1988, *How easy is local search?* (?) [1·B]; `MixBarrington1989Bounded` Mix Barrington 1989, *Bounded-width polynomial-size branching programs recognize…* (?) [1·B]; `Papadimitriou1994Complexity` Papadimitriou 1994, *Complexity of the parity argument and other inefficient…* (?) [1·B]; `SaksZhou1999BP` Saks–Zhou 1999, *BP_H SPACE(S) ⊆ DSPACE(S^{3/2})* (?) [1·B]; `KhotRegev2008Vertex` Khot–Regev 2008, *Vertex cover might be hard to approximate to within 2−ε* (?) [1·C]
- *C. R. Acad. Sci. Paris* (9): `Serre1978Formule` Serre 1978, *Une "formule de masse" pour les extensions totalement…* [2·A]; `Rentschler1968Operations` Rentschler 1968, *Opérations du groupe additif sur le plan affine* (?) [1·A]; `Serre1983Nombre` Serre 1983, *Sur le nombre des points rationnels d'une courbe algébrique…* [1·A]; `BeilinsonBernstein1981Localisation` Beilinson–Bernstein 1981, *Localisation de g-modules* (?) [1·B]; `BerlineVergne1982Classes` Berline–Vergne 1982, *Classes caractéristiques équivariantes. Formule de…* (?) [1·B]; `BorhoMacPherson1981Representations` Borho–MacPherson 1981, *Représentations des groupes de Weyl et homologie…* (?) [1·B]; `GeorgievMathieu1992Categorie` Georgiev–Mathieu 1992, *Catégorie de fusion pour les groupes de Chevalley* (?) [1·B]; `BeauvilleLaszlo1995Lemme` Beauville–Laszlo 1995, *Un lemme de descente* (?) [2·C]; `BeauvilleDonagi1985Variete` Beauville–Donagi 1985, *La variété des droites d'une hypersurface cubique de…* (?) [1·C]
- *J. Algebra* (8): `AbhyankarEakinHeinzer1972Uniqueness` Abhyankar–Eakin–Heinzer 1972, *Uniqueness of the coefficient ring in a polynomial ring* (?) [1·A]; `Bowditch2012Relatively` Bowditch 2012, *Relatively hyperbolic groups* (?) [1·A]; `DriesWilkie1984Gromov` van den Dries–Wilkie 1984, *Gromov's theorem on groups of polynomial growth and…* (?) [1·A]; `Dyer1990Reflection` Dyer 1990, *Reflection subgroups of Coxeter systems* (?) [1·A]; `Pizer1980Algorithm` Pizer 1980, *Algorithm for computing modular forms on Γ0(N)* [1·A]; `Dong1993Vertex` Dong 1993, *Vertex algebras associated with even lattices* (?) [1·B]; `Rudakov1997Stability` Rudakov 1997, *Stability for an abelian category* (?) [1·B]; `Swan1969Groups` Swan 1969, *Groups of cohomological dimension one* (?) [1·B]
- *J. Number Theory* (8): `GrevePauli2012Ramification` Greve–Pauli 2012, *Ramification polygons, splitting fields, and Galois groups…* [1·A]; `Heiermann1996Nouveaux` Heiermann 1996, *De nouveaux invariants numériques pour les extensions…* [1·A]; `Hildebrand1986Number` Hildebrand 1986, *Number of positive integers <= x and free of prime factors…* [1·A]; `Kenku1982Number` Kenku 1982, *Number of Q-isomorphism classes of elliptic curves in each…* [1·A]; `Malle2002Distribution` Malle 2002, *Distribution of Galois groups* (?) [1·A]; `Perlis1977Equation` Perlis 1977, *Equation ζ_K(s) = ζ_K'(s)* (?) [1·A]; `Pohst1982Computation` Pohst 1982, *Computation of number fields of small discriminants…* [1·A]; `TzanakisWeger1989Practical` Tzanakis–de Weger 1989, *Practical solution of the Thue equation* [1·A]
- *J. Pure Appl. Algebra* (7): `Bass1993Covering` Bass 1993, *Covering theory for graphs of groups* (?) [1·A]; `Broughton1991Classifying` Broughton 1991, *Classifying finite group actions on surfaces of low genus* (?) [1·A]; `Joyal2002Quasi` Joyal 2002, *Quasi-categories and Kan complexes* (?) [1·A]; `Ara2013Homotopy` Ara 2013, *Homotopy theory of Grothendieck ∞-groupoids* (?) [1·B]; `Street1987Algebra` Street 1987, *Algebra of oriented simplexes* (?) [1·B]; `Scheiderer1992Quasi` Scheiderer 1992, *Quasi-augmented simplicial spaces, with an application to…* (?) [1·C]; `SuslinJoukhovitski2006Norm` Suslin–Joukhovitski 2006, *Norm varieties* (?) [1·C]
- *J. Funct. Anal.* (5): `CoifmanMeyerStein1985New` Coifman–Meyer–Stein 1985, *Some new function spaces and their applications to harmonic…* (?) [1·A]; `CorderoErausquinFradeliziMaurey2004B` Cordero-Erausquin et al. 2004, *(B) conjecture for the Gaussian measure of dilates of…* (?) [1·A]; `BlackadarHandelman1982Dimension` Blackadar–Handelman 1982, *Dimension functions and traces on C*-algebras* (?) [1·B]; `Bowditch1993Geometrical` Bowditch 1993, *Geometrical finiteness for hyperbolic groups* (?) [1·B]; `GolseEtAl1988Regularity` Golse et al. 1988, *Regularity of the moments of the solution of a transport…* (?) [1·B]
- *Theoret. Comput. Sci.* (5): `EmdeBoas1990Machine` van Emde Boas 1990, *Machine models and simulations* (?) [2·A]; `BuchbinderNaor2009Design` Buchbinder–Naor 2009, *Design of competitive online algorithms via a primal–dual…* (?) [1·A]; `Grigoriev2001Linear` Grigoriev 2001, *Linear lower bound on degrees of Positivstellensatz…* (?) [1·A]; `ShpilkaYehudayoff2010Arithmetic` Shpilka–Yehudayoff 2010, *Arithmetic circuits* (?) [1·A]; `JerrumValiantVazirani1986Random` Jerrum–Valiant–Vazirani 1986, *Random generation of combinatorial structures from a…* (?) [1·B]
- *J. Math. Pures Appl.* (3): `Aronszajn1957Unique` Aronszajn 1957, *Unique continuation theorem for solutions of elliptic…* (?) [2·A]; `GinibreVelo1985Scattering` Ginibre–Velo 1985, *Scattering theory in the energy space for a class of…* (?) [1·A]; `Waldspurger1981Coefficients` Waldspurger 1981, *Sur les coefficients de Fourier des formes modulaires de…* [1·A]
- *Discrete Math.* (2): `Gasharov1996Incomparability` Gasharov 1996, *Incomparability graphs of (3+1)-free posets are s-positive* (?) [1·A]; `Shearer1983Note` Shearer 1983, *Note on the independence number of triangle-free graphs* (?) [1·A]
- *European J. Combin.* (2): `AhlswedeKhachatrian1997Complete` Ahlswede–Khachatrian 1997, *Complete intersection theorem for systems of finite sets* (?) [1·A]; `ThomasWollan2005Improved` Thomas–Wollan 2005, *Improved linear edge bound for graph linkages* (?) [1·B]
- *Linear Algebra Appl.* (2): `Haemers1995Interlacing` Haemers 1995, *Interlacing eigenvalues and graphs* (?) [1·A]; `McKay1981Expected` McKay 1981, *Expected eigenvalue distribution of a large regular graph* (?) [1·B]
- *Nonlinear Anal.* (2): `DiBenedetto1983C` DiBenedetto 1983, *C^{1+α} local regularity of weak solutions of degenerate…* (?) [1·B]; `Tartar1979Compensated` Tartar 1979, *Compensated compactness and applications to partial…* (?) [1·B]
- *Ann. Inst. H. Poincaré* (?) (1): `Steele1989Kingman` Steele 1989, *Kingman's subadditive ergodic theorem* (?) [1·A]
- *Ann. Physics* (1): `WoottersFields1989Optimal` Wootters–Fields 1989, *Optimal state-determination by mutually unbiased…* (?) [2·A]
- *Ann. Pure Appl. Logic* (1): `BlassGurevichShelah1999Choiceless` Blass–Gurevich–Shelah 1999, *Choiceless polynomial time* (?) [1·A]
- *Expo. Math.* (1): `Vaisala2005Gromov` Väisälä 2005, *Gromov hyperbolic spaces* (?) [1·A]
- *Games Econom. Behav.* (1): `KleinbergWeinberg2019Matroid` Kleinberg–Weinberg 2019, *Matroid prophet inequalities and applications to…* (?) [1·A]
- *Indag. Math.* (1): `Bruijn1972Lambda` de Bruijn 1972, *Lambda calculus notation with nameless dummies, a tool for…* (?) [1·A]
- *Inform. Comput.* (1): `Takahashi1995Parallel` Takahashi 1995, *Parallel reductions in λ-calculus* (?) [1·A]
- *J. Differential Equations* (1): `Pfaffelmoser1992Global` Pfaffelmoser 1992, *Global classical solutions of the Vlasov–Poisson system in…* (?) [1·B]
- *J. Math. Anal. Appl.* (1): `GilbertPearson1987Subordinacy` Gilbert–Pearson 1987, *Subordinacy and analysis of the spectrum of one-dimensional…* (?) [1·B]
- *J. Symbolic Comput.* (1): `DettweilerReiter2000Algorithm` Dettweiler–Reiter 2000, *Algorithm of Katz and its application to the inverse Galois…* (?) [1·B]
- *Phys. Lett. B* (1): `BelavinEtAl1975Pseudoparticle` Belavin et al. 1975, *Pseudoparticle solutions of the Yang–Mills equations* (?) [1·A]

**Other (10)**

- `Tate1977Local` Tate 1977, *Local constants* [2·A] — Algebraic Number Fields: L-functions and Galois Properties (ed. A. Fröhlich, Durham 1975), Academic Press, 89-
- `Bjorner1995Topological` Björner 1995, *Topological methods* (?) [1·A] — in Handbook of Combinatorics, Vol. II, Elsevier, 1819–1872
- `Kasteleyn1967Graph` Kasteleyn 1967, *Graph theory and crystal physics* (?) [1·A] — in Graph Theory and Theoretical Physics (F. Harary, ed.), Academic Press, 43–110
- `Kotani1984Ljapunov` Kotani 1984, *Ljapunov indices determine absolutely continuous spectra of…* (?) [1·B] — in Stochastic Analysis (Katata/Kyoto, 1982), North-Holland Mathematical Library 32, 225–247
- `LagariasOdlyzko1977Effective` Lagarias–Odlyzko 1977, *Effective versions of the Chebotarev density theorem* (?) [1·B] — Algebraic Number Fields: L-functions and Galois Properties (ed. A. Fröhlich, Durham 1975), Academic Press, 409
- `Martinet1977Character` Martinet 1977, *Character theory and Artin L-functions* (?) [1·B] — Algebraic Number Fields: L-functions and Galois Properties (ed. A. Fröhlich, Durham 1975), Academic Press, 1-8
- `Villani2002Review` Villani 2002, *Review of mathematical topics in collisional kinetic theory* (?) [1·B] — Handbook of Mathematical Fluid Dynamics, Vol. I, North-Holland, 71–305
- `Kleiman1968Algebraic` Kleiman 1968, *Algebraic cycles and the Weil conjectures* (?) [1·C] — in Dix exposés sur la cohomologie des schémas, North-Holland, 359–386
- `Margulis1989Discrete` Margulis 1989, *Discrete subgroups and ergodic theory* (?) [1·C] — Number Theory, Trace Formulas and Discrete Groups (Oslo 1987), Academic Press, 377–398
- `Milne1990Canonical` Milne 1990, *Canonical models of (mixed) Shimura varieties and…* [1·C] — Automorphic Forms, Shimura Varieties, and L-functions I (Ann Arbor 1988), Perspect. Math. 10, Academic Press, 

### Cambridge University Press — 163

**Books (122)**

- `BrunsHerzog1998Cohen` Bruns–Herzog 1998, *Cohen–Macaulay Rings* (?) [5·A] — Cambridge Studies in Advanced Mathematics 39
- `KollarMori1998Birational` Kollár–Mori 1998, *Birational Geometry of Algebraic Varieties* (?) [4·A] — Cambridge Tracts in Math. 134
- `Maggi2012Sets` Maggi 2012, *Sets of Finite Perimeter and Geometric Variational Problems* (?) [4·A] — Cambridge Studies in Advanced Mathematics 135
- `Mattila1995Geometry` Mattila 1995, *Geometry of Sets and Measures in Euclidean Spaces* (?) [4·A] — Cambridge Studies in Advanced Mathematics 44
- `BombieriGubler2006Heights` Bombieri–Gubler 2006, *Heights in Diophantine Geometry* [3·A] — New Mathematical Monographs 4
- `Bump1997Automorphic` Bump 1997, *Automorphic Forms and Representations* [3·A] — Cambridge Studies in Advanced Mathematics 55
- `Fulton1997Young` Fulton 1997, *Young Tableaux* (?) [3·A] — London Mathematical Society Student Texts 35
- `KatokHasselblatt1995Modern` Katok–Hasselblatt 1995, *Modern Theory of Dynamical Systems* (?) [3·A] — Encyclopedia of Mathematics and its Applications 54
- `LidlNiederreiter1997Finite` Lidl–Niederreiter 1997, *Finite Fields* [3·A] — Encyclopedia of Mathematics and its Applications 20
- `Mattila2015Fourier` Mattila 2015, *Fourier Analysis and Hausdorff Dimension* (?) [3·A] — Cambridge Studies in Advanced Mathematics 150
- `Milne2017Algebraic` Milne 2017, *Algebraic Groups* (?) [3·A] — Cambridge Studies in Advanced Mathematics 170
- `Stanley1999Enumerative` Stanley 1999, *Enumerative Combinatorics, Volume 2* (?) [3·A] — Cambridge Studies in Advanced Mathematics 62
- `TaoVu2006Additive` Tao–Vu 2006, *Additive Combinatorics* [3·A] — Cambridge Studies in Advanced Mathematics 105
- `Voisin2002Hodge` Voisin 2002, *Hodge Theory and Complex Algebraic Geometry I* (?) [3·A] — Cambridge Studies in Advanced Math. 76
- `Voisin2003Hodge` Voisin 2003, *Hodge Theory and Complex Algebraic Geometry II* (?) [3·A] — Cambridge Studies in Advanced Math. 77
- `Zhao2023Graph` Zhao 2023, *Graph Theory and Additive Combinatorics* (?) [3·A] — —
- `CarlsonMullerStachPeters2017Period` Carlson–Müller-Stach–Peters 2017, *Period Mappings and Period Domains* (?) [2·A] — Cambridge Studies in Advanced Math. 168
- `Demeter2020Fourier` Demeter 2020, *Fourier Restriction, Decoupling, and Applications* (?) [2·A] — Cambridge Studies in Advanced Mathematics 184
- `DigneMichel2020Representations` Digne–Michel 2020, *Representations of Finite Groups of Lie Type* (?) [2·A] — LMS Student Texts 95
- `Geiges2008Contact` Geiges 2008, *Contact Topology* (?) [2·A] — Cambridge Studies in Advanced Mathematics 109
- `HuybrechtsLehn2010Geometry` Huybrechts–Lehn 2010, *Geometry of Moduli Spaces of Sheaves* [2·A] — Cambridge Mathematical Library
- `Kollar2013Singularities` Kollár 2013, *Singularities of the Minimal Model Program* (?) [2·A] — Cambridge Tracts in Math. 200
- `Matsumura1986Commutative` Matsumura 1986, *Commutative Ring Theory* (?) [2·A] — Cambridge Studies in Advanced Mathematics 8
- `MontgomeryVaughan2007Multiplicative` Montgomery–Vaughan 2007, *Multiplicative Number Theory I. Classical Theory* [2·A] — Cambridge Studies in Advanced Mathematics 97
- `MuscaluSchlag2013Classical` Muscalu–Schlag 2013, *Classical and Multilinear Harmonic Analysis, Vols. I–II* (?) [2·A] — Cambridge Studies in Advanced Mathematics 137–138
- `Paulsen2002Completely` Paulsen 2002, *Completely Bounded Maps and Operator Algebras* (?) [2·A] — Cambridge Studies in Advanced Mathematics 78
- `Pila2022Point` Pila 2022, *Point-Counting and the Zilber-Pink Conjecture* [2·A] — Cambridge Tracts in Mathematics 228
- `Ruelle2004Thermodynamic` Ruelle 2004, *Thermodynamic Formalism* (?) [2·A] — Cambridge Mathematical Library
- `Stanley2012Enumerative` Stanley 2012, *Enumerative Combinatorics, Volume 1* [2·A] — Cambridge Studies in Advanced Mathematics 49
- `AngeleriHugelHappelKrause2007Handbook` Angeleri Hügel–Happel–Krause 2007, *Handbook of Tilting Theory* (?) [1·A] — LMS Lecture Note Series 332
- `Aschbacher2000Finite` Aschbacher 2000, *Finite Group Theory* [1·A] — Cambridge Studies in Advanced Mathematics 10
- `AssemSimsonSkowronski2006Elements` Assem–Simson–Skowroński 2006, *Representation Theory of Associative Algebras, Vol. 1* (?) [1·A] — LMS Student Texts 65
- `AuslanderReitenSmalo1995Representation` Auslander–Reiten–Smalø 1995, *Representation Theory of Artin Algebras* (?) [1·A] — Cambridge Studies in Advanced Mathematics 36
- `Barlow2017Random` Barlow 2017, *Random Walks and Heat Kernels on Graphs* (?) [1·A] — London Math. Soc. Lecture Note Ser. 438
- `BethJungnickelLenz1999Design` Beth–Jungnickel–Lenz 1999, *Design Theory (2 vols.)* (?) [1·A] — Encyclopedia of Mathematics and its Applications 69 and 78
- `BishopPeres2017Fractals` Bishop–Peres 2017, *Fractals in Probability and Analysis* (?) [1·A] — Cambridge Studies in Advanced Mathematics 162
- `BollobasRiordan2006Percolation` Bollobás–Riordan 2006, *Percolation* (?) [1·A] — —
- `Breuer2000Characters` Breuer 2000, *Characters and Automorphism Groups of Compact Riemann…* (?) [1·A] — LMS Lecture Note Series 280
- `Carter2005Lie` Carter 2005, *Lie Algebras of Finite and Affine Type* (?) [1·A] — Cambridge Studies in Advanced Mathematics 96
- `CasselsFlynn1996Prolegomena` Cassels–Flynn 1996, *Prolegomena to a Middlebrow Arithmetic of Curves of Genus 2* [1·A] — LMS Lecture Note Series 230
- `DicksDunwoody1989Groups` Dicks–Dunwoody 1989, *Groups Acting on Graphs* (?) [1·A] — Cambridge Studies in Advanced Mathematics 17
- `Dolgachev2003Lectures` Dolgachev 2003, *Invariant Theory* [1·A] — LMS Lecture Note Series 296
- `EisenbudHarris2016All` Eisenbud–Harris 2016, *3264 and All That* (?) [1·A] — —
- `Frenkel2007Langlands` Frenkel 2007, *Langlands Correspondence for Loop Groups* (?) [1·A] — Cambridge Studies in Advanced Mathematics 103
- `Gardner2006Geometric` Gardner 2006, *Geometric Tomography* (?) [1·A] — Encyclopedia of Mathematics and its Applications 58
- `GarnettMarshall2005Harmonic` Garnett–Marshall 2005, *Harmonic Measure* (?) [1·A] — New Mathematical Monographs 2
- `GirondoGonzalezDiez2012Compact` Girondo–González-Diez 2012, *Compact Riemann Surfaces and Dessins d'Enfants* [1·A] — LMS Student Texts 79
- `GoodearlWarfield2004Noncommutative` Goodearl–Warfield 2004, *Noncommutative Noetherian Rings* (?) [1·A] — LMS Student Texts 61
- `Groemer1996Geometric` Groemer 1996, *Geometric Applications of Fourier Series and Spherical…* (?) [1·A] — Encyclopedia of Mathematics and its Applications 61
- `Happel1988Triangulated` Happel 1988, *Triangulated Categories in the Representation Theory of…* (?) [1·A] — LMS Lecture Note Series 119
- `HuffmanPless2003Fundamentals` Huffman–Pless 2003, *Fundamentals of Error-Correcting Codes* [1·A] — —
- `Humphreys1990Reflection` Humphreys 1990, *Reflection Groups and Coxeter Groups* (?) [1·A] — Cambridge Studies in Advanced Mathematics 29
- `JonesSunder1997Subfactors` Jones–Sunder 1997, *Subfactors* (?) [1·A] — London Mathematical Society Lecture Note Series 234
- `Kac1990Infinite` Kac 1990, *Infinite Dimensional Lie Algebras* (?) [1·A] — —
- `Katznelson2004Harmonic` Katznelson 2004, *Harmonic Analysis* (?) [1·A] — Cambridge Mathematical Library
- `KleidmanLiebeck1990Subgroup` Kleidman–Liebeck 1990, *Subgroup Structure of the Finite Classical Groups* (?) [1·A] — LMS Lecture Note Series 129
- `LawlerLimic2010Random` Lawler–Limic 2010, *Random Walk* (?) [1·A] — Cambridge Studies in Advanced Mathematics 123
- `Linckelmann2018Block` Linckelmann 2018, *Block Theory of Finite Group Algebras, Vols. I–II* (?) [1·A] — LMS Student Texts 91–92
- `Mukai2003Invariants` Mukai 2003, *Invariants and Moduli* [1·A] — Cambridge Studies in Advanced Math. 81
- `Navarro1998Characters` Navarro 1998, *Characters and Blocks of Finite Groups* (?) [1·A] — LMS Lecture Note Series 250
- `Neumaier1990Interval` Neumaier 1990, *Interval Methods for Systems of Equations* (?) [1·A] — Encyclopedia of Mathematics and its Applications 37
- `Norris1997Markov` Norris 1997, *Markov Chains* (?) [1·A] — Cambridge Series in Statistical and Probabilistic Mathematics
- `Pisier2003Operator` Pisier 2003, *Operator Space Theory* (?) [1·A] — London Mathematical Society Lecture Note Series 294
- `PolyanskiyWu2025Information` Polyanskiy–Wu 2025, *Information Theory* (?) [1·A] — —
- `Ranicki1992Algebraic` Ranicki 1992, *Algebraic L-Theory and Topological Manifolds* (?) [1·A] — Cambridge Tracts in Mathematics 102
- `Ransford1995Potential` Ransford 1995, *Potential Theory in the Complex Plane* (?) [1·A] — London Mathematical Society Student Texts 28
- `Schneider2014Convex` Schneider 2014, *Convex Bodies* (?) [1·A] — Encyclopedia of Mathematics and its Applications 151
- `Segal1983Polycyclic` Segal 1983, *Polycyclic Groups* (?) [1·A] — Cambridge Tracts in Mathematics 82
- `SinclairSmith1995Hochschild` Sinclair–Smith 1995, *Hochschild Cohomology of von Neumann Algebras* (?) [1·A] — London Mathematical Society Lecture Note Series 203
- `SinclairSmith2008Finite` Sinclair–Smith 2008, *Finite von Neumann Algebras and Masas* (?) [1·A] — London Mathematical Society Lecture Note Series 351
- `Sogge2017Fourier` Sogge 2017, *Fourier Integrals in Classical Analysis* (?) [1·A] — Cambridge Tracts in Mathematics 210
- `Stephenson2005Circle` Stephenson 2005, *Circle Packing* (?) [1·A] — —
- `Szamuely2009Galois` Szamuely 2009, *Galois Groups and Fundamental Groups* [1·A] — Cambridge Studies in Advanced Mathematics 117
- `Terras2011Zeta` Terras 2011, *Zeta Functions of Graphs* (?) [1·A] — Cambridge Studies in Advanced Mathematics 128
- `Watson1944Treatise` Watson 1944, *Treatise on the Theory of Bessel Functions* (?) [1·A] — —
- `Webb2016Course` Webb 2016, *Finite Group Representation Theory* [1·A] — Cambridge Studies in Advanced Mathematics 161
- `Woess2000Random` Woess 2000, *Random Walks on Infinite Graphs and Groups* (?) [1·A] — Cambridge Tracts in Mathematics 138
- `Zygmund2002Trigonometric` Zygmund 2002, *Trigonometric Series, Vols. I & II* (?) [1·A] — Cambridge Mathematical Library
- `BarnesRoitzheim2020Foundations` Barnes–Roitzheim 2020, *Foundations of Stable Homotopy Theory* (?) [2·B] — Cambridge Studies in Advanced Mathematics 185
- `AlldayPuppe1993Cohomological` Allday–Puppe 1993, *Cohomological Methods in Transformation Groups* (?) [1·B] — Cambridge Studies in Advanced Mathematics 32
- `AndersonFulton2023Equivariant` Anderson–Fulton 2023, *Equivariant Cohomology in Algebraic Geometry* (?) [1·B] — Cambridge Studies in Advanced Math. 210
- `Andrews1976Theory` Andrews 1976, *Theory of Partitions* (?) [1·B] — Encyclopedia of Mathematics and its Applications 2, Addison-Wesley (Cambridge reprint 1998)
- `Baker1975Transcendental` Baker 1975, *Transcendental Number Theory* (?) [1·B] — (Cambridge Mathematical Library reissue 2022)
- `Beauville1996Complex` Beauville 1996, *Complex Algebraic Surfaces* (?) [1·B] — LMS Student Texts 34
- `Blackadar1998K` Blackadar 1998, *K-Theory for Operator Algebras* (?) [1·B] — Mathematical Sciences Research Institute Publications 5
- `DiestelJarchowTonge1995Absolutely` Diestel–Jarchow–Tonge 1995, *Absolutely Summing Operators* (?) [1·B] — Cambridge Studies in Advanced Mathematics 43
- `Downarowicz2011Entropy` Downarowicz 2011, *Entropy in Dynamical Systems* (?) [1·B] — New Mathematical Monographs 18
- `FrankLaptevWeidl2023Schrodinger` Frank–Laptev–Weidl 2023, *Schrödinger Operators* (?) [1·B] — Cambridge Studies in Advanced Mathematics 200
- `GeckMalle2020Character` Geck–Malle 2020, *Character Theory of Finite Groups of Lie Type* (?) [1·B] — Cambridge Studies in Advanced Mathematics 187
- `GoebelKirk1990Topics` Goebel–Kirk 1990, *Metric Fixed Point Theory* (?) [1·B] — Cambridge Studies in Advanced Mathematics 28
- `HawkingEllis1973Large` Hawking–Ellis 1973, *Large Scale Structure of Space-Time* (?) [1·B] — Cambridge Monographs on Mathematical Physics
- `Humphreys2006Modular` Humphreys 2006, *Modular Representations of Finite Groups of Lie Type* (?) [1·B] — LMS Lecture Note Series 326
- `KalethaPrasad2023Bruhat` Kaletha–Prasad 2023, *Bruhat–Tits Theory* (?) [1·B] — New Mathematical Monographs 44
- `Kedlaya2010P` Kedlaya 2010, *p-adic Differential Equations* (?) [1·B] — Cambridge Studies in Advanced Math. 125
- `Kitaoka1993Arithmetic` Kitaoka 1993, *Arithmetic of Quadratic Forms* (?) [1·B] — Cambridge Tracts in Mathematics 106
- `Klingen1990Introductory` Klingen 1990, *Siegel Modular Forms* (?) [1·B] — Cambridge Studies in Advanced Mathematics 20
- `Li2012Geometric` Li 2012, *Geometric Analysis* (?) [1·B] — Cambridge Studies in Advanced Mathematics 134
- `LindMarcus1995Symbolic` Lind–Marcus 1995, *Symbolic Dynamics and Coding* (?) [1·B] — —
- `MoeglinWaldspurger1995Spectral` Mœglin–Waldspurger 1995, *Spectral Decomposition and Eisenstein Series* (?) [1·B] — Cambridge Tracts in Mathematics 113
- `Neeman2007Algebraic` Neeman 2007, *Algebraic and Analytic Geometry* (?) [1·B] — LMS Lecture Note Series 345
- `NicaSpeicher2006Lectures` Nica–Speicher 2006, *Combinatorics of Free Probability* (?) [1·B] — London Mathematical Society Lecture Note Series 335
- `Pisier1989Volume` Pisier 1989, *Volume of Convex Bodies and Banach Space Geometry* (?) [1·B] — Cambridge Tracts in Mathematics 94
- `Pisier2016Martingales` Pisier 2016, *Martingales in Banach Spaces* (?) [1·B] — Cambridge Studies in Advanced Mathematics 155
- `Potier1997Lectures` Le Potier 1997, *Vector Bundles* (?) [1·B] — Cambridge Studies in Advanced Math. 54
- `Roberts1998Multiplicities` Roberts 1998, *Multiplicities and Chern Classes in Local Algebra* (?) [1·B] — Cambridge Tracts in Mathematics 133
- `Rogers1964Packing` Rogers 1964, *Packing and Covering* (?) [1·B] — Cambridge Tracts in Mathematics and Mathematical Physics 54
- `RordamLarsenLaustsen2000K` Rørdam–Larsen–Laustsen 2000, *K-Theory for C*-Algebras* (?) [1·B] — London Mathematical Society Student Texts 49
- `SouleEtAl1992Lectures` Soulé et al. 1992, *Arakelov Geometry* (?) [1·B] — Cambridge Studies in Advanced Mathematics 33
- `Stum2007Rigid` Le Stum 2007, *Rigid Cohomology* (?) [1·B] — Cambridge Tracts in Math. 172
- `Vaughan1997Hardy` Vaughan 1997, *Hardy-Littlewood Method* [1·B] — Cambridge Tracts in Mathematics 125
- `Wall2004Singular` Wall 2004, *Singular Points of Plane Curves* (?) [1·B] — LMS Student Texts 63
- `WillettYu2020Higher` Willett–Yu 2020, *Higher Index Theory* (?) [1·B] — Cambridge Studies in Advanced Mathematics 189
- `AshEtAl2010Smooth` Ash et al. 2010, *Smooth Compactifications of Locally Symmetric Varieties* (?) [1·C] — Cambridge Mathematical Library
- `BarreiraPesin2007Nonuniform` Barreira–Pesin 2007, *Nonuniform Hyperbolicity* (?) [1·C] — Encyclopedia of Mathematics and its Applications 115
- `BekkaMayer2000Ergodic` Bekka–Mayer 2000, *Ergodic Theory and Topological Dynamics of Group Actions on…* (?) [1·C] — London Math. Soc. Lecture Note Ser. 269
- `DerezinskiGerard2013Mathematics` Dereziński–Gérard 2013, *Mathematics of Quantization and Quantum Fields* (?) [1·C] — Cambridge Monographs on Mathematical Physics
- `Hida1993Elementary` Hida 1993, *Elementary Theory of L-functions and Eisenstein Series* (?) [1·C] — LMS Student Texts 26
- `HillHopkinsRavenel2021Equivariant` Hill–Hopkins–Ravenel 2021, *Equivariant Stable Homotopy Theory and the Kervaire…* (?) [1·C] — New Mathematical Monographs 40
- `KronheimerMrowka2007Monopoles` Kronheimer–Mrowka 2007, *Monopoles and Three-Manifolds* (?) [1·C] — New Mathematical Monographs 10
- `LiebSeiringer2010Stability` Lieb–Seiringer 2010, *Stability of Matter in Quantum Mechanics* (?) [1·C] — —
- `Viana2014Lectures` Viana 2014, *Lyapunov Exponents* (?) [1·C] — Cambridge Studies in Advanced Mathematics 145
- `Weibel1994Homological` Weibel 1994, *Homological Algebra* [1·C] — Cambridge Studies in Advanced Mathematics 38

**Journal papers (32)**

- *Canad. J. Math. / Canad. Math. Bull.* (?) (6): `Tutte1963Census` Tutte 1963, *Census of planar maps* (?) [2·A]; `DranishnikovEtAl2002Uniform` Dranishnikov et al. 2002, *Uniform embeddings into Hilbert space and a question of…* (?) [1·A]; `Muller1968Classification` Müller 1968, *Classification of algebras by dominant dimension* (?) [1·A]; `Zagier1985Modular` Zagier 1985, *Modular parametrizations of elliptic curves* (?) [1·B]; `Kolster1989Relation` Kolster 1989, *Relation between the 2-primary parts of the main conjecture…* [1·C]; `Soule1985Operations` Soulé 1985, *Opérations en K-théorie algébrique* [1·C]
- *Math. Proc. Cambridge Philos. Soc.* (4): `Beke2000Sheafifiable` Beke 2000, *Sheafifiable homotopy model categories* (?) [1·A]; `Birkhoff1935Structure` Birkhoff 1935, *Structure of abstract algebras* (?) [1·A]; `Thomason1979Homotopy` Thomason 1979, *Homotopy colimits in the category of small categories* (?) [1·A]; `Thomason1984Extremal` Thomason 1984, *Extremal function for contractions of graphs* (?) [1·B]
- *Nagoya Math. J.* (?) (4): `Niwa1975Modular` Niwa 1975, *Modular forms of half integral weight and the integral of…* [1·A]; `Shintani1975Construction` Shintani 1975, *Construction of holomorphic cusp forms of half integral…* [1·A]; `Tahara1971Finite` Tahara 1971, *Finite subgroups of GL(3, Z)* (?) [1·A]; `Mukai1981Duality` Mukai 1981, *Duality between D(X) and D(X̂) with its application to…* (?) [1·B]
- *Combin. Probab. Comput.* (3): `Alon1999Combinatorial` Alon 1999, *Combinatorial Nullstellensatz* (?) [1·A]; `KiersteadKostochka2008Short` Kierstead–Kostochka 2008, *Short proof of the Hajnal–Szemerédi theorem on equitable…* (?) [1·A]; `PachSharir1998Number` Pach–Sharir 1998, *Number of incidences between points and curves* (?) [1·A]
- *Mathematika* (?) (3): `MontgomeryVaughan1973Large` Montgomery–Vaughan 1973, *Large sieve* (?) [1·B]; `Roth1955Rational` Roth 1955, *Rational approximations to algebraic numbers* (?) [1·B]; `SpanierWhitehead1955Duality` Spanier–Whitehead 1955, *Duality in homotopy theory* (?) [1·B]
- *Compositio Math.* (2): `Ambro2005Moduli` Ambro 2005, *Moduli b-divisor of an lc-trivial fibration* (?) [1·C]; `IharaKanekoZagier2006Derivation` Ihara–Kaneko–Zagier 2006, *Derivation and double shuffle relations for multiple zeta…* (?) [1·C]
- *Forum Math. Pi/Sigma* (2): `Wan2015Iwasawa` Wan 2015, *Iwasawa main conjecture for Hilbert modular forms* (?) [2·C]; `EischenEtAl2020P` Eischen et al. 2020, *p-adic L-functions for unitary groups* [1·C]
- *J. Aust. Math. Soc.* (2): `BooneHigman1974Algebraic` Boone–Higman 1974, *Algebraic characterization of groups with soluble word…* (?) [1·A]; `BorweinWolkowicz1981Facial` Borwein–Wolkowicz 1981, *Facial reduction for a cone-convex programming problem* (?) [1·A]
- *Acta Numer.* (1): `Rump2010Verification` Rump 2010, *Verification methods* (?) [1·A]
- *Ergodic Theory Dynam. Systems* (1): `Katok1982Entropy` Katok 1982, *Entropy and closed geodesics* (?) [1·C]
- *J. Appl. Probab.* (?) (1): `BergKesten1985Inequalities` van den Berg–Kesten 1985, *Inequalities with applications to percolation and…* (?) [1·A]
- *J. Inst. Math. Jussieu* (1): `Conrad2007Arithmetic` Conrad 2007, *Arithmetic moduli of generalized elliptic curves* [1·A]
- *J. Symbolic Logic* (?) (1): `FriedmanStanley1989Borel` Friedman–Stanley 1989, *Borel reducibility theory for classes of countable…* (?) [1·A]
- *LMS J. Comput. Math.* (?) (1): `BookerStrombergssonThen2013Bounds` Booker–Strömbergsson–Then 2013, *Bounds and algorithms for the K-Bessel function of…* [1·A]

**Other (9)**

- `BrylawskiOxley1992Tutte` Brylawski–Oxley 1992, *Tutte polynomial and its applications* (?) [1·A] — in Matroid Applications (N. White, ed.), Encyclopedia Math. Appl. 40, Cambridge University Press, 123–225
- `Gross1998Satake` Gross 1998, *Satake isomorphism* (?) [1·A] — Galois Representations in Arithmetic Algebraic Geometry, LMS Lecture Note Series 254, 223–237
- `Schneps1997Grothendieck` Schneps 1997, *Grothendieck–Teichmüller group GT-hat* (?) [1·A] — Geometric Galois Actions 1, LMS Lecture Note Series 242, 183–203
- `BoucksomEtAl2015Valuation` Boucksom et al. 2015, *Valuation spaces and multiplier ideals on singular varieties* (?) [1·B] — in Recent Advances in Algebraic Geometry, LMS Lecture Note Series 417, 29–51
- `Buzzard2007Eigenvarieties` Buzzard 2007, *Eigenvarieties* (?) [1·C] — L-functions and Galois Representations, LMS Lecture Note Series 320, Cambridge University Press, 59-120
- `CalegariEmerton2012Completed` Calegari–Emerton 2012, *Completed cohomology - a survey* (?) [1·C] — Non-abelian Fundamental Groups and Iwasawa Theory, LMS Lecture Note Series 393, Cambridge University Press, 23
- `ColemanMazur1998Eigencurve` Coleman–Mazur 1998, *Eigencurve* (?) [1·C] — Galois Representations in Arithmetic Algebraic Geometry, LMS Lecture Note Series 254, Cambridge University Pre
- `Conrad2004Gross` Conrad 2004, *Gross-Zagier revisited* [1·C] — Heegner Points and Rankin L-Series, MSRI Publ. 49, Cambridge University Press, 67-163
- `GoerssHopkins2004Moduli` Goerss–Hopkins 2004, *Moduli spaces of commutative ring spectra* (?) [1·C] — in Structured Ring Spectra, London Mathematical Society Lecture Note Series 315, Cambridge University Press, 1

### Princeton University Press / Annals of Mathematics (Annals of Mathematics) — 150

**Books (52)**

- `Shimura1971Arithmetic` Shimura 1971, *Arithmetic Theory of Automorphic Functions* [4·A] — Publications of the Mathematical Society of Japan 11, Iwanami Shoten and
- `Stein1993Harmonic` Stein 1993, *Harmonic Analysis* (?) [3·A] — Princeton Mathematical Series 43
- `BerthelotOgus1978Notes` Berthelot–Ogus 1978, *Crystalline Cohomology* [2·A] — Mathematical Notes 21
- `Davis2008Geometry` Davis 2008, *Geometry and Topology of Coxeter Groups* (?) [2·A] — London Mathematical Society Monographs 32
- `LawsonMichelsohn1989Spin` Lawson–Michelsohn 1989, *Spin Geometry* (?) [2·A] — Princeton Mathematical Series 38
- `Milne1980Etale` Milne 1980, *Étale Cohomology* [2·A] — Princeton Mathematical Series 33
- `Milnor1971Algebraic` Milnor 1971, *Algebraic K-Theory* (?) [2·A] — Annals of Mathematics Studies 72
- `MilnorStasheff1974Characteristic` Milnor–Stasheff 1974, *Characteristic Classes* (?) [2·A] — Annals of Mathematics Studies 76
- `SteinWeiss1971Fourier` Stein–Weiss 1971, *Fourier Analysis on Euclidean Spaces* (?) [2·A] — Princeton Mathematical Series 32
- `AstalaIwaniecMartin2009Elliptic` Astala–Iwaniec–Martin 2009, *Elliptic Partial Differential Equations and Quasiconformal…* (?) [1·A] — Princeton Mathematical Series 48
- `Bhatia2007Positive` Bhatia 2007, *Positive Definite Matrices* (?) [1·A] — Princeton Series in Applied Mathematics
- `Fulton1993Toric` Fulton 1993, *Toric Varieties* (?) [1·A] — Annals of Math. Studies 131
- `GreenGriffithsKerr2012Mumford` Green–Griffiths–Kerr 2012, *Mumford–Tate Groups and Domains* (?) [1·A] — Annals of Math. Studies 183
- `KatzMazur1985Arithmetic` Katz–Mazur 1985, *Arithmetic Moduli of Elliptic Curves* [1·A] — Annals of Mathematics Studies 108
- `Mumford1966Lectures` Mumford 1966, *Curves on an Algebraic Surface* [1·A] — Annals of Math. Studies 59
- `Simon1993Statistical` Simon 1993, *Statistical Mechanics of Lattice Gases, Vol. I* (?) [1·A] — —
- `Tucker2011Validated` Tucker 2011, *Validated Numerics* (?) [1·A] — —
- `Wise2021Structure` Wise 2021, *Structure of Groups with a Quasiconvex Hierarchy* (?) [1·A] — Annals of Mathematics Studies 209
- `Mostow1973Strong` Mostow 1973, *Strong Rigidity of Locally Symmetric Spaces* (?) [2·B] — Annals of Mathematics Studies 78
- `Adams1978Infinite` Adams 1978, *Infinite Loop Spaces* (?) [1·B] — Annals of Mathematics Studies 90
- `Agmon1982Lectures` Agmon 1982, *Exponential Decay of Solutions of Second-Order Elliptic…* (?) [1·B] — Mathematical Notes 29
- `Borel1960Seminar` Borel 1960, *Seminar on Transformation Groups* (?) [1·B] — Annals of Mathematics Studies 46
- `FarbMargalit2012Primer` Farb–Margalit 2012, *Primer on Mapping Class Groups* (?) [1·B] — Princeton Mathematical Series 49
- `FathiLaudenbachPoenaru2012Thurston` Fathi–Laudenbach–Poénaru 2012, *Thurston's Work on Surfaces* (?) [1·B] — Mathematical Notes 48 (transl. of Astérisque 66–67, 1979)
- `Furstenberg1981Recurrence` Furstenberg 1981, *Recurrence in Ergodic Theory and Combinatorial Number Theory* (?) [1·B] — M. B. Porter Lectures
- `Hempel1976Manifolds` Hempel 1976, *3-Manifolds* (?) [1·B] — Annals of Mathematics Studies 86
- `Katz1990Exponential` Katz 1990, *Exponential Sums and Differential Equations* (?) [1·B] — Annals of Mathematics Studies 124
- `Katz1996Rigid` Katz 1996, *Rigid Local Systems* (?) [1·B] — Annals of Math. Studies 139
- `Kobayashi1987Differential` Kobayashi 1987, *Differential Geometry of Complex Vector Bundles* (?) [1·B] — Publ. Math. Soc. Japan 15, Iwanami Shoten /
- `Laufer1971Normal` Laufer 1971, *Normal Two-Dimensional Singularities* (?) [1·B] — Annals of Math. Studies 71
- `Lusztig1984Characters` Lusztig 1984, *Characters of Reductive Groups over a Finite Field* (?) [1·B] — Annals of Mathematics Studies 107
- `Milnor1963Morse` Milnor 1963, *Morse Theory* (?) [1·B] — Annals of Mathematics Studies 51
- `Milnor1968Singular` Milnor 1968, *Singular Points of Complex Hypersurfaces* (?) [1·B] — Annals of Math. Studies 61
- `Pitts1981Existence` Pitts 1981, *Existence and Regularity of Minimal Surfaces on Riemannian…* (?) [1·B] — Mathematical Notes 27
- `Shimura1998Abelian` Shimura 1998, *Abelian Varieties with Complex Multiplication and Modular…* (?) [1·B] — Princeton Mathematical Series 46
- `Simon2011Szego` Simon 2011, *Szegő's Theorem and Its Descendants* (?) [1·B] — M. B. Porter Lectures
- `Steenrod1951Topology` Steenrod 1951, *Topology of Fibre Bundles* (?) [1·B] — Princeton Mathematical Series 14
- `SteenrodEpstein1962Cohomology` Steenrod–Epstein 1962, *Cohomology Operations* (?) [1·B] — Annals of Mathematics Studies 50
- `Stong1968Notes` Stong 1968, *Cobordism Theory* (?) [1·B] — Mathematical Notes 7
- `WaldhausenJahrenRognes2013Spaces` Waldhausen–Jahren–Rognes 2013, *Spaces of PL Manifolds and Categories of Simple Maps* (?) [1·B] — Annals of Mathematics Studies 186
- `Brakke1978Motion` Brakke 1978, *Motion of a Surface by Its Mean Curvature* (?) [1·C] — Mathematical Notes 20
- `BushnellKutzko1993Admissible` Bushnell–Kutzko 1993, *Admissible Dual of GL(N) via Compact Open Subgroups* (?) [1·C] — Annals of Mathematics Studies 129
- `ChristodoulouKlainerman1993Global` Christodoulou–Klainerman 1993, *Global Nonlinear Stability of the Minkowski Space* (?) [1·C] — Princeton Mathematical Series 41
- `Folland1989Harmonic` Folland 1989, *Harmonic Analysis in Phase Space* (?) [1·C] — Annals of Mathematics Studies 122
- `FreedmanQuinn1990Topology` Freedman–Quinn 1990, *Topology of 4-Manifolds* (?) [1·C] — Princeton Mathematical Series 39
- `HaesemeyerWeibel2019Norm` Haesemeyer–Weibel 2019, *Norm Residue Theorem in Motivic Cohomology* (?) [1·C] — Annals of Mathematics Studies 200
- `HarrisTaylor2001Geometry` Harris–Taylor 2001, *Geometry and Cohomology of Some Simple Shimura Varieties* (?) [1·C] — Annals of Mathematics Studies 151
- `Morgan1996Seiberg` Morgan 1996, *Seiberg–Witten Equations and Applications to the Topology…* (?) [1·C] — Mathematical Notes 44
- `Ravenel1992Nilpotence` Ravenel 1992, *Nilpotence and Periodicity in Stable Homotopy Theory* (?) [1·C] — Annals of Mathematics Studies 128
- `StreaterWightman1964PCT` Streater–Wightman 1964, *PCT, Spin and Statistics, and All That* (?) [1·C] — W. A. Benjamin; reprinted Princeton Landmarks in Mathematics and Physics (2000)
- `VoevodskySuslinFriedlander2000Cycles` Voevodsky–Suslin–Friedlander 2000, *Cycles, Transfers, and Motivic Homology Theories* (?) [1·C] — Annals of Mathematics Studies 143
- `YuanZhangZhang2013Gross` Yuan–Zhang–Zhang 2013, *Gross-Zagier Formula on Shimura Curves* [1·C] — Annals of Mathematics Studies 184

**Journal papers (97)**

- *Ann. of Math.* (97): `Igusa1960Arithmetic` Igusa 1960, *Arithmetic variety of moduli for genus two* [2·A]; `Serre1953Groupes` Serre 1953, *Groupes d'homotopie et classes de groupes abéliens* (?) [2·A]; `AndreottiFrankel1959Lefschetz` Andreotti–Frankel 1959, *Lefschetz theorem on hyperplane sections* (?) [1·A]; `AschbacherSmith1993Quillen` Aschbacher–Smith 1993, *Quillen's conjecture for the p-subgroups complex* (?) [1·A]; `BailyBorel1966Compactification` Baily–Borel 1966, *Compactification of arithmetic quotients of bounded…* [1·A]; `Bott1957Homogeneous` Bott 1957, *Homogeneous vector bundles* (?) [1·A]; `CheegerGromoll1972Structure` Cheeger–Gromoll 1972, *Structure of complete manifolds of nonnegative curvature* (?) [1·A]; `ChernSimons1974Characteristic` Chern–Simons 1974, *Characteristic forms and geometric invariants* (?) [1·A]; `CoifmanMcIntoshMeyer1982Lintegrale` Coifman–McIntosh–Meyer 1982, *L'intégrale de Cauchy définit un opérateur borné sur L²…* (?) [1·A]; `Coleman1985Torsion` Coleman 1985, *Torsion points on curves and p-adic abelian integrals* [1·A]; `Connes1976Classification` Connes 1976, *Classification of injective factors. Cases II_1, II_∞…* (?) [1·A]; `DavidJourne1984Boundedness` David–Journé 1984, *Boundedness criterion for generalized Calderón–Zygmund…* (?) [1·A]; `Fox1953Free` Fox 1953, *Free differential calculus. I* [1·A]; `Haboush1975Reductive` Haboush 1975, *Reductive groups are geometrically reductive* (?) [1·A]; `Hironaka1964Resolution` Hironaka 1964, *Resolution of singularities of an algebraic variety over a… II* (?) [1·A]; `Karoubi1980Theoreme` Karoubi 1980, *Le théorème fondamental de la K-théorie hermitienne* (?) [1·A]; `Kleiman1966Toward` Kleiman 1966, *Toward a numerical theory of ampleness* (?) [1·A]; `Littelmann1995Paths` Littelmann 1995, *Paths and root operators in representation theory* (?) [1·A]; `LubinTate1965Formal` Lubin–Tate 1965, *Formal complex multiplication in local fields* [1·A]; `PaoliniShelah2024Torsion` Paolini–Shelah 2024, *Torsion-free abelian groups are Borel complete* (?) [1·A]; `ReingoldVadhanWigderson2002Entropy` Reingold–Vadhan–Wigderson 2002, *Entropy waves, the zig-zag graph product, and new…* (?) [1·A]; `Shimizu1965Zeta` Shimizu 1965, *Zeta functions of quaternion algebras* [1·A]; `Shimura1973Modular` Shimura 1973, *Modular forms of half integral weight* [1·A]; `Uchida1977Isomorphisms` Uchida 1977, *Isomorphisms of Galois groups of algebraic function fields* [1·A]; `Wiles1990Iwasawa` Wiles 1990, *Iwasawa conjecture for totally real fields* [1·A]; `Mori1979Projective` Mori 1979, *Projective manifolds with ample tangent bundles* (?) [2·B]; `Quillen1971Spectrum` Quillen 1971, *Spectrum of an equivariant cohomology ring I, II* (?) [2·B]; `Quillen1972Cohomology` Quillen 1972, *Cohomology and K-theory of the general linear groups over a…* (?) [2·B]; `Adams1960Non` Adams 1960, *Non-existence of elements of Hopf invariant one* (?) [1·B]; `Adams1962Vector` Adams 1962, *Vector fields on spheres* (?) [1·B]; `Allard1972First` Allard 1972, *First variation of a varifold* (?) [1·B]; `Artin1970Algebraization` Artin 1970, *Algebraization of formal moduli II* (?) [1·B]; `AtiyahSinger1968Index` Atiyah–Singer 1968, *Index of elliptic operators I, III* (?) [1·B]; `AtiyahSinger1971Index` Atiyah–Singer 1971, *Index of elliptic operators IV* (?) [1·B]; `Bhargava2005Density` Bhargava 2005, *Density of discriminants of quartic rings and fields* (?) [1·B]; `BialynickiBirula1973Theorems` Białynicki-Birula 1973, *Some theorems on actions of algebraic groups* (?) [1·B]; `Borel1953Cohomologie` Borel 1953, *Sur la cohomologie des espaces fibrés principaux et des…* (?) [1·B]; `Bott1959Stable` Bott 1959, *Stable homotopy of the classical groups* [1·B]; `Browder1969Kervaire` Browder 1969, *Kervaire invariant of framed manifolds and its…* [1·B]; `Brown1962Cohomology` Brown 1962, *Cohomology theories* (?) [1·B]; `CataldoHauselMigliorini2012Topology` de Cataldo–Hausel–Migliorini 2012, *Topology of Hitchin systems and Hodge theory of character…* (?) [1·B]; `ColdingMinicozzi1997Harmonic` Colding–Minicozzi 1997, *Harmonic functions on manifolds* (?) [1·B]; `Cuntz1981K` Cuntz 1981, *K-theory for certain C*-algebras* (?) [1·B]; `DeligneLusztig1976Representations` Deligne–Lusztig 1976, *Representations of reductive groups over finite fields* (?) [1·B]; `DiPernaLions1989Cauchy` DiPerna–Lions 1989, *Cauchy problem for Boltzmann equations* (?) [1·B]; `Faltings1984Calculus` Faltings 1984, *Calculus on arithmetic surfaces* (?) [1·B]; `FedererFleming1960Normal` Federer–Fleming 1960, *Normal and integral currents* (?) [1·B]; `FugledeKadison1952Determinant` Fuglede–Kadison 1952, *Determinant theory in finite factors* (?) [1·B]; `Ge1998Applications` Ge 1998, *Applications of free entropy to finite von Neumann… II* (?) [1·B]; `Grayson1989Shortening` Grayson 1989, *Shortening embedded curves* (?) [1·B]; `GromovLawson1980Classification` Gromov–Lawson 1980, *Classification of simply connected manifolds of positive…* (?) [1·B]; `HarveyHoeven2021Integer` Harvey–van der Hoeven 2021, *Integer multiplication in time O(n log n)* (?) [1·B]; `KavehKhovanskii2012Newton` Kaveh–Khovanskii 2012, *Newton–Okounkov bodies, semigroups of integral points…* (?) [1·B]; `Kodaira1954Kahler` Kodaira 1954, *Kähler varieties of restricted type (an intrinsic…* (?) [1·B]; `Kodaira1963Compact` Kodaira 1963, *Compact analytic surfaces II, III* (?) [1·B]; `Kollar1986Higher` Kollár 1986, *Higher direct images of dualizing sheaves I* (?) [1·B]; `Kottwitz1988Tamagawa` Kottwitz 1988, *Tamagawa numbers* (?) [1·B]; `MattilaMelnikovVerdera1996Cauchy` Mattila–Melnikov–Verdera 1996, *Cauchy integral, analytic capacity, and uniform…* (?) [1·B]; `Milnor1956Construction` Milnor 1956, *Construction of universal bundles, II* (?) [1·B]; `Milnor1956Manifolds` Milnor 1956, *Manifolds homeomorphic to the 7-sphere* (?) [1·B]; `Milnor1958Steenrod` Milnor 1958, *Steenrod algebra and its dual* (?) [1·B]; `MiyaokaMori1986Numerical` Miyaoka–Mori 1986, *Numerical criterion for uniruledness* (?) [1·B]; `Mori1982Threefolds` Mori 1982, *Threefolds whose canonical bundles are not numerically…* (?) [1·B]; `NarasimhanSeshadri1965Stable` Narasimhan–Seshadri 1965, *Stable and unitary vector bundles on a compact Riemann…* (?) [1·B]; `Ono1963Tamagawa` Ono 1963, *Tamagawa number of algebraic tori* (?) [1·B]; `Ono1965Relative` Ono 1965, *Relative theory of Tamagawa numbers* (?) [1·B]; `Papakyriakopoulos1957Dehn` Papakyriakopoulos 1957, *Dehn's lemma and the asphericity of knots* (?) [1·B]; `Pisier1982Holomorphic` Pisier 1982, *Holomorphic semigroups and the geometry of Banach spaces* (?) [1·B]; `Powers1967Representations` Powers 1967, *Representations of uniformly hyperfinite algebras and their…* (?) [1·B]; `Reider1988Vector` Reider 1988, *Vector bundles of rank 2 and linear systems on algebraic…* (?) [1·B]; `Savin2009Regularity` Savin 2009, *Regularity of flat level sets in phase transitions* (?) [1·B]; `Siegel1935Analytische` Siegel 1935, *Über die analytische Theorie der quadratischen Formen* (?) [1·B]; `Siegel1945Mean` Siegel 1945, *Mean value theorem in geometry of numbers* (?) [1·B]; `Simons1968Minimal` Simons 1968, *Minimal varieties in Riemannian manifolds* (?) [1·B]; `Smith1938Transformations` Smith 1938, *Transformations of finite period* (?) [1·B]; `Sunada1985Riemannian` Sunada 1985, *Riemannian coverings and isospectral manifolds* (?) [1·B]; `SylvesterUhlmann1987Global` Sylvester–Uhlmann 1987, *Global uniqueness theorem for an inverse boundary value…* (?) [1·B]; `Waldhausen1968Irreducible` Waldhausen 1968, *Irreducible 3-manifolds which are sufficiently large* (?) [1·B]; `Whitney1965Tangents` Whitney 1965, *Tangents to an analytic variety* (?) [1·B]; `Wolpert1983Symplectic` Wolpert 1983, *Symplectic geometry of deformations of a hyperbolic surface* (?) [1·B]; `Zariski1962Theorem` Zariski 1962, *Theorem of Riemann–Roch for high multiples of an effective…* (?) [1·B]; `Zhang1998Equidistribution` Zhang 1998, *Equidistribution of small points on abelian varieties* (?) [1·B]; `Shin2011Galois` Shin 2011, *Galois representations arising from some compact Shimura…* (?) [2·C]; `Bloch1974K2` Bloch 1974, *K₂ and algebraic cycles* (?) [1·C]; `Carlsson1984Equivariant` Carlsson 1984, *Equivariant stable homotopy and Segal's Burnside ring…* (?) [1·C]; `CheegerColding1996Lower` Cheeger–Colding 1996, *Lower bounds on Ricci curvature and the almost rigidity of…* (?) [1·C]; `DevinatzHopkinsSmith1988Nilpotence` Devinatz–Hopkins–Smith 1988, *Nilpotence and stable homotopy theory I* (?) [1·C]; `Goodwillie1986Relative` Goodwillie 1986, *Relative algebraic K-theory and cyclic homology* (?) [1·C]; `Griffiths1969Periods` Griffiths 1969, *Periods of certain rational integrals I, II* (?) [1·C]; `HopkinsSmith1998Nilpotence` Hopkins–Smith 1998, *Nilpotence and stable homotopy theory II* (?) [1·C]; `KhotMinzerSafra2023Pseudorandom` Khot–Minzer–Safra 2023, *Pseudorandom sets in Grassmann graph have near-perfect…* (?) [1·C]; `LedrappierYoung1985Metric` Ledrappier–Young 1985, *Metric entropy of diffeomorphisms. Parts I and II* (?) [1·C]; `LiXu2014Special` Li–Xu 2014, *Special test configuration and K-stability of Fano varieties* (?) [1·C]; `MillerRavenelWilson1977Periodic` Miller–Ravenel–Wilson 1977, *Periodic phenomena in the Adams–Novikov spectral sequence* (?) [1·C]; `Odaka2013GIT` Odaka 2013, *GIT stability of polarized varieties via discrepancy* (?) [1·C]; `Ratner1991Raghunathan` Ratner 1991, *Raghunathan's measure conjecture* (?) [1·C]; `Wall1965Finiteness` Wall 1965, *Finiteness conditions for CW-complexes* (?) [1·C]

**Other (1)**

- `Tate1967Fourier` Tate 1967, *Fourier analysis in number fields and Hecke's zeta-functions* [3·A] — thesis (Princeton 1950), printed in Cassels-Fröhlich, Algebraic Number Theory, Ch. XV

### Wiley — 40

**Books (20)**

- `JansonLuczakRucinski2000Random` Janson–Łuczak–Ruciński 2000, *Random Graphs* (?) [3·A] — -Interscience Series in Discrete Mathematics and Optimization
- `AlonSpencer2016Probabilistic` Alon–Spencer 2016, *Probabilistic Method* (?) [2·A] — Series in Discrete Mathematics and Optimization
- `BerndtEvansWilliams1998Gauss` Berndt–Evans–Williams 1998, *Gauss and Jacobi Sums* [2·A] — Canadian Mathematical Society Series of Monographs and Advanced Texts
- `GriffithsHarris1978Principles` Griffiths–Harris 1978, *Principles of Algebraic Geometry* (?) [2·A] — -Interscience
- `KobayashiNomizu1969Foundations` Kobayashi–Nomizu 1969, *Foundations of Differential Geometry, Vol. II* (?) [2·A] — Interscience ()
- `CurtisReiner1981Methods` Curtis–Reiner 1981, *Methods of Representation Theory, Vol. I* (?) [1·A] — —
- `CurtisReiner1987Methods` Curtis–Reiner 1987, *Methods of Representation Theory, Vol. II* (?) [1·A] — —
- `Falconer2014Fractal` Falconer 2014, *Fractal Geometry* (?) [1·A] — —
- `GrahamRothschildSpencer1990Ramsey` Graham–Rothschild–Spencer 1990, *Ramsey Theory* (?) [1·A] — -Interscience Series in Discrete Mathematics and Optimization
- `Hille1976Ordinary` Hille 1976, *Ordinary Differential Equations in the Complex Domain* (?) [1·A] — -Interscience (Dover reprint 1997)
- `JensenToft1995Graph` Jensen–Toft 1995, *Graph Coloring Problems* (?) [1·A] — -Interscience Series in Discrete Mathematics and Optimization
- `KobayashiNomizu1963Foundations` Kobayashi–Nomizu 1963, *Foundations of Differential Geometry, Vol. I* (?) [1·A] — Interscience ()
- `MoodyPianzola1995Lie` Moody–Pianzola 1995, *Lie Algebras with Triangular Decompositions* (?) [1·A] — Canadian Mathematical Society Series of Monographs
- `Passman1977Algebraic` Passman 1977, *Algebraic Structure of Group Rings* (?) [1·A] — -Interscience (Dover reprint 2011)
- `Schrijver1986Theory` Schrijver 1986, *Theory of Linear and Integer Programming* (?) [1·A] — -Interscience Series in Discrete Mathematics and Optimization
- `StiebitzEtAl2012Graph` Stiebitz et al. 2012, *Graph Edge Coloring* (?) [1·A] — —
- `Wasow1965Asymptotic` Wasow 1965, *Asymptotic Expansions for Ordinary Differential Equations* (?) [1·A] — Pure and Applied Mathematics 14, Interscience
- `Carter1985Finite` Carter 1985, *Finite Groups of Lie Type* (?) [1·B] — —
- `KuipersNiederreiter1974Uniform` Kuipers–Niederreiter 1974, *Uniform Distribution of Sequences* (?) [1·B] — (Dover reprint 2006)
- `Nagata1962Local` Nagata 1962, *Local Rings* (?) [1·B] — Interscience Tracts in Pure and Applied Mathematics 13

**Journal papers (20)**

- *Comm. Pure Appl. Math.* (13): `FengHu2009Dimension` Feng–Hu 2009, *Dimension theory of iterated function systems* (?) [2·A]; `LeeUhlmann1989Determining` Lee–Uhlmann 1989, *Determining anisotropic real-analytic conductivities by…* (?) [2·A]; `ChengYau1976Regularity` Cheng–Yau 1976, *Regularity of the solution of the n-dimensional Minkowski…* (?) [1·A]; `Glimm1965Solutions` Glimm 1965, *Solutions in the large for nonlinear hyperbolic systems of…* (?) [1·A]; `John1981Blow` John 1981, *Blow-up for quasilinear wave equations in three space…* (?) [1·A]; `Bartnik1986Mass` Bartnik 1986, *Mass of an asymptotically flat manifold* (?) [1·B]; `CaffarelliGidasSpruck1989Asymptotic` Caffarelli–Gidas–Spruck 1989, *Asymptotic symmetry and local behavior of semilinear…* (?) [1·B]; `GidasSpruck1981Global` Gidas–Spruck 1981, *Global and local behavior of positive solutions of…* (?) [1·B]; `KohnVogelius1984Determining` Kohn–Vogelius 1984, *Determining conductivity by boundary measurements* (?) [1·B]; `Modica1985Gradient` Modica 1985, *Gradient bound and a Liouville theorem for nonlinear…* (?) [1·B]; `Nirenberg1953Weyl` Nirenberg 1953, *Weyl and Minkowski problems in differential geometry in the…* (?) [1·B]; `SimonWolff1986Singular` Simon–Wolff 1986, *Singular continuous spectrum under rank one perturbations…* (?) [1·B]; `UhlenbeckYau1986Existence` Uhlenbeck–Yau 1986, *Existence of Hermitian–Yang–Mills connections in stable…* (?) [1·C]
- *J. Graph Theory* (3): `AharoniHaxell2000Hall` Aharoni–Haxell 2000, *Hall's theorem for hypergraphs* (?) [1·A]; `Dvorak2010Recognizing` Dvořák 2010, *Recognizing graphs by numbers of homomorphisms* (?) [1·A]; `Thomassen1983Theorem` Thomassen 1983, *Theorem on paths in planar graphs* (?) [1·B]
- *Random Structures Algorithms* (2): `Banaszczyk1998Balancing` Banaszczyk 1998, *Balancing vectors and Gaussian measures of n-dimensional…* (?) [1·A]; `Kim1995Ramsey` Kim 1995, *Ramsey number R(3,t) has order of magnitude t²/log t* (?) [1·A]
- *Int. J. Quantum Chem.* (1): `Lieb1983Density` Lieb 1983, *Density functionals for Coulomb systems* (?) [1·C]
- *Math. Nachr.* (1): `Gunther1989Einbettungssatz` Günther 1989, *Zum Einbettungssatz von J. Nash* (?) [1·B]

### Société Mathématique de France (SMF, Séminaire Bourbaki) — 33

**Books (9)**

- `Tenenbaum2015Analytic` Tenenbaum 2015, *Analytic and Probabilistic Number Theory* [3·A] — Graduate Studies in Mathematics 163
- `Renard2010Representations` Renard 2010, *Représentations des groupes réductifs p-adiques* (?) [1·A] — Cours Spécialisés 17, Société Mathématique de France
- `Serre2020Rational` Serre 2020, *Rational Points on Curves over Finite Fields* [1·A] — Documents Mathématiques 18, Société Mathématique de France
- `AraMaltsiniotis2020Joint` Ara–Maltsiniotis 2020, *Joint et tranches pour les ∞-catégories strictes* (?) [1·B] — Mémoires de la Société Mathématique de France 165
- `DavidSemmes1991Singular` David–Semmes 1991, *Singular integrals and rectifiable sets in ℝⁿ* (?) [1·B] — Astérisque 193
- `KashiwaraSchapira1985Microlocal` Kashiwara–Schapira 1985, *Microlocal study of sheaves* (?) [1·B] — Astérisque 128
- `Andre2004Aux` André 2004, *Une introduction aux motifs (motifs purs, motifs mixtes…* (?) [1·C] — Panoramas et Synthèses 17
- `Kollar1992Flips` Kollár 1992, *Flips and Abundance for Algebraic Threefolds* (?) [1·C] — Astérisque 211
- `KottwitzShelstad1999Foundations` Kottwitz–Shelstad 1999, *Foundations of twisted endoscopy* (?) [1·C] — Astérisque 255

**Journal papers (17)**

- *Astérisque* (14): `HyodoKato1994Semi` Hyodo–Kato 1994, *Semi-stable reduction and crystalline cohomology with…* (?) [2·A]; `Fontaine2013Perfectoides` Fontaine 2013, *Perfectoïdes, presque pureté et monodromie-poids (d'après…* (?) [1·A]; `AndersenJantzenSoergel1994Representations` Andersen–Jantzen–Soergel 1994, *Representations of quantum groups at a p-th root of unity…* (?) [1·B]; `Atiyah1976Elliptic` Atiyah 1976, *Elliptic operators, discrete groups and von Neumann algebras* (?) [1·B]; `Broue1990Isometries` Broué 1990, *Isométries parfaites, types de blocs, catégories dérivées* (?) [1·B]; `Deligne1985Preuve` Deligne 1985, *Preuve des conjectures de Tate et Shafarevitch [d'après G…* (?) [1·B]; `Fontaine1994Corps` Fontaine 1994, *Le corps des périodes p-adiques* (?) [1·B]; `Illusie1994Autour` Illusie 1994, *Autour du théorème de monodromie locale* [1·B]; `Raynaud1985Hauteurs` Raynaud 1985, *Hauteurs et isogénies* (?) [1·B]; `Teissier1973Cycles` Teissier 1973, *Cycles évanescents, sections planes et conditions de Whitney* (?) [1·B]; `AndreattaIovitaPilloni2016Overconvergent` Andreatta–Iovita–Pilloni 2016, *Overconvergent Hilbert modular cusp forms* (?) [1·C]; `Colmez2010Representations` Colmez 2010, *Représentations de GL_2(Q_p) et (phi,Gamma)-modules* (?) [1·C]; `Hida2005P` Hida 2005, *p-adic automorphic forms on reductive groups* (?) [1·C]; `Lusztig1983Singularities` Lusztig 1983, *Singularities, character formulas, and a q-analog of weight…* (?) [1·C]
- *Bull. Soc. Math. France* (3): `Berger1955Groupes` Berger 1955, *Sur les groupes d'holonomie homogène des variétés à…* (?) [1·A]; `BorelSerre1958Theoreme` Borel–Serre 1958, *Le théorème de Riemann–Roch* (?) [1·A]; `Herr1998Cohomologie` Herr 1998, *Sur la cohomologie galoisienne des corps p-adiques* (?) [1·B]

**Other (7)**

- `BoutotCarayol1991Uniformisation` Boutot–Carayol 1991, *Uniformisation p-adique des courbes de Shimura* [1·A] — Courbes modulaires et courbes de Shimura, Astérisque 196-197, 45-158
- `Grothendieck1961Techniques` Grothendieck 1961, *Techniques de construction et théorèmes d'existence en…* (?) [1·A] — Séminaire Bourbaki, exp. 221, 232, 236
- `Conrad2014Reductive` Conrad 2014, *Reductive group schemes* (?) [1·B] — in Autour des schémas en groupes I, Panoramas et Synthèses 42–43, SMF, 93–444
- `Grothendieck1983Pursuing` Grothendieck 1983, *Pursuing Stacks (À la poursuite des champs)* (?) [1·B] — manuscript 1983; ed. G. Maltsiniotis, Documents Mathématiques 20, Société Mathématique de France, 2022
- `Mars1969Nombres` Mars 1969, *Les nombres de Tamagawa de certains groupes algébriques* (?) [1·B] — Séminaire Bourbaki 1968/69, exp. 351
- `Tate1966Conjectures` Tate 1966, *Conjectures of Birch and Swinnerton-Dyer and a geometric…* (?) [1·B] — Séminaire Bourbaki 1965/66, exp. 306
- `Verdier1965Dualite` Verdier 1965, *Dualité dans la cohomologie des espaces localement compacts* (?) [1·B] — Séminaire Bourbaki 9 (1965/66), exposé 300

### Oxford University Press — 30

**Books (20)**

- `AmbrosioFuscoPallara2000Functions` Ambrosio–Fusco–Pallara 2000, *Functions of Bounded Variation and Free Discontinuity…* (?) [3·A] — Oxford Mathematical Monographs
- `Huybrechts2006Fourier` Huybrechts 2006, *Fourier–Mukai Transforms in Algebraic Geometry* (?) [2·A] — Oxford Mathematical Monographs, Oxford Univ. Press
- `BoucheronLugosiMassart2013Concentration` Boucheron–Lugosi–Massart 2013, *Concentration Inequalities* (?) [1·A] — —
- `Braides2002Convergence` Braides 2002, *Γ-convergence for Beginners* (?) [1·A] — Oxford Lecture Series in Mathematics and its Applications 22
- `Bressan2000Hyperbolic` Bressan 2000, *Hyperbolic Systems of Conservation Laws* (?) [1·A] — Oxford Lecture Series in Mathematics and its Applications 20
- `GeckPfeiffer2000Characters` Geck–Pfeiffer 2000, *Characters of Finite Coxeter Groups and Iwahori–Hecke…* (?) [1·A] — LMS Monographs (N.S.) 21
- `Hirschfeld1998Projective` Hirschfeld 1998, *Projective Geometries over Finite Fields* (?) [1·A] — Oxford Mathematical Monographs
- `Iwasawa1986Local` Iwasawa 1986, *Local Class Field Theory* [1·A] — Oxford Mathematical Monographs
- `Liu2002Algebraic` Liu 2002, *Algebraic Geometry and Arithmetic Curves* [1·A] — Oxford Graduate Texts in Mathematics 6
- `Macdonald1995Symmetric` Macdonald 1995, *Symmetric Functions and Hall Polynomials* (?) [1·A] — Oxford Mathematical Monographs, Clarendon Press
- `Reiner1975Maximal` Reiner 1975, *Maximal Orders* (?) [1·A] — LMS Monographs 5 ( reprint 2003)
- `Reutenauer1993Free` Reutenauer 1993, *Free Lie Algebras* (?) [1·A] — LMS Monographs (N.S.) 7
- `ChoquetBruhat2009General` Choquet-Bruhat 2009, *General Relativity and the Einstein Equations* (?) [2·B] — Oxford Mathematical Monographs
- `Corti2007Flips` Corti 2007, *Flips for 3-folds and 4-folds* (?) [2·B] — Oxford Lecture Series in Math. and its Applications 35, Oxford Univ. Press
- `HigsonRoe2000Analytic` Higson–Roe 2000, *Analytic K-Homology* (?) [1·B] — Oxford Mathematical Monographs
- `Klimek1991Pluripotential` Klimek 1991, *Pluripotential Theory* (?) [1·B] — London Mathematical Society Monographs (N.S.) 6
- `Araki1999Mathematical` Araki 1999, *Mathematical Theory of Quantum Fields* (?) [1·C] — International Series of Monographs on Physics 101
- `BehrensEtAl2021Disc` Behrens et al. 2021, *Disc Embedding Theorem* (?) [1·C] — —
- `DonaldsonKronheimer1990Geometry` Donaldson–Kronheimer 1990, *Geometry of Four-Manifolds* (?) [1·C] — Oxford Mathematical Monographs
- `Ranicki2002Algebraic` Ranicki 2002, *Algebraic and Geometric Surgery* (?) [1·C] — Oxford Mathematical Monographs

**Journal papers (8)**

- *Q. J. Math.* (5): `Hall1936Eulerian` Hall 1936, *Eulerian functions of a group* (?) [1·A]; `HeathBrown1986Artin` Heath-Brown 1986, *Artin's conjecture for primitive roots* [1·A]; `King1994Moduli` King 1994, *Moduli of representations of finite dimensional algebras* (?) [1·A]; `AdamsAtiyah1966K` Adams–Atiyah 1966, *K-theory and the Hopf invariant* (?) [1·B]; `Newman1931Theorem` Newman 1931, *Theorem on periodic transformations of spaces* (?) [1·B]
- *IMRN* (3): `MignonRessayre2004Quadratic` Mignon–Ressayre 2004, *Quadratic bound for the determinant and permanent problem* (?) [1·A]; `Scheithauer2009Weil` Scheithauer 2009, *Weil representation of SL2(Z) and some applications* (?) [1·A]; `Voevodsky2002Motivic` Voevodsky 2002, *Motivic cohomology groups are isomorphic to higher Chow…* (?) [2·C]

**Other (2)**

- `Barendregt1992Lambda` Barendregt 1992, *Lambda calculi with types* (?) [1·A] — in Handbook of Logic in Computer Science, Vol. 2, Oxford University Press, 117–309
- `Grothendieck1969Standard` Grothendieck 1969, *Standard conjectures on algebraic cycles* (?) [1·C] — in Algebraic Geometry (Bombay Colloquium 1968), Oxford Univ. Press, 193–199

### Johns Hopkins University Press — 26

**Journal papers (25)**

- *Amer. J. Math.* (25): `Erdos1939Family` Erdős 1939, *Family of symmetric Bernoulli convolutions* (?) [2·A]; `Andreotti1958Theorem` Andreotti 1958, *Theorem of Torelli* (?) [1·A]; `Bolza1887Binary` Bolza 1887, *Binary sextics with linear transformations into themselves* (?) [1·A]; `ErdosKac1940Gaussian` Erdős–Kac 1940, *Gaussian law of errors in the theory of additive number…* [1·A]; `ErdosWintner1939Additive` Erdős–Wintner 1939, *Additive arithmetical functions and statistical independence* [1·A]; `Fogarty1968Algebraic` Fogarty 1968, *Algebraic families on an algebraic surface* [1·A]; `JiangSu1999Simple` Jiang–Su 1999, *Simple unital projectionless C*-algebra* (?) [1·A]; `KleimanLaksov1972Existence` Kleiman–Laksov 1972, *Existence of special divisors* (?) [1·A]; `Artin1962Numerical` Artin 1962, *Some numerical criteria for contractability of curves on…* (?) [1·B]; `Artin1966Isolated` Artin 1966, *Isolated rational singularities of surfaces* (?) [1·B]; `Chow1949Compact` Chow 1949, *Compact complex analytic varieties* (?) [1·B]; `EdidinGraham1998Localization` Edidin–Graham 1998, *Localization in equivariant intersection theory and the…* (?) [1·B]; `Igusa1962Siegel` Igusa 1962, *Siegel modular forms of genus two* (?) [1·B]; `JacquetPiatetskiShapiroShalika1983Rankin` Jacquet et al. 1983, *Rankin-Selberg convolutions* (?) [1·B]; `KirchbergRordam2000Non` Kirchberg–Rørdam 2000, *Non-simple purely infinite C*-algebras* (?) [1·B]; `Lang1956Algebraic` Lang 1956, *Algebraic groups over finite fields* (?) [1·B]; `Milnor1962Unique` Milnor 1962, *Unique decomposition theorem for 3-manifolds* (?) [1·B]; `Nagata1959Th` Nagata 1959, *14-th problem of Hilbert* (?) [1·B]; `TrangRamanujam1976Invariance` Tráng–Ramanujam 1976, *Invariance of Milnor's number implies the invariance of the…* (?) [1·B]; `Zariski1965Studies` Zariski 1965, *Studies in equisingularity I–III* (?) [1·B]; `EellsSampson1964Harmonic` Eells–Sampson 1964, *Harmonic mappings of Riemannian manifolds* (?) [1·C]; `Kawamata1998Subadjunction` Kawamata 1998, *Subadjunction of log canonical divisors II* (?) [1·C]; `Landweber1976Homological` Landweber 1976, *Homological properties of comodules over MU_*(MU) and…* (?) [1·C]; `Milnor1960Cobordism` Milnor 1960, *Cobordism ring Ω* and a complex analogue, Part I* (?) [1·C]; `Ravenel1984Localization` Ravenel 1984, *Localization with respect to certain periodic homology…* (?) [1·C]

**Other (1)**

- `Kato1989Logarithmic` Kato 1989, *Logarithmic structures of Fontaine–Illusie* [1·A] — in Algebraic Analysis, Geometry, and Number Theory, Johns Hopkins Univ. Press, 191–224

### De Gruyter Brill (Vandenhoeck & Ruprecht) — 21

**Books (6)**

- `Georgii2011Gibbs` Georgii 2011, *Gibbs Measures and Phase Transitions* (?) [2·A] — Studies in Mathematics 9
- `Ostrovskii2013Metric` Ostrovskii 2013, *Metric Embeddings* (?) [2·A] — Studies in Mathematics 49
- `DoerkHawkes1992Finite` Doerk–Hawkes 1992, *Finite Soluble Groups* (?) [1·A] — Expositions in Mathematics 4
- `Holevo2012Quantum` Holevo 2012, *Quantum Systems, Channels, Information* (?) [1·A] — Studies in Mathematical Physics 16
- `Pommerenke1975Univalent` Pommerenke 1975, *Univalent Functions* (?) [1·A] — Vandenhoeck & Ruprecht, Göttingen
- `TomDieck1987Transformation` tom Dieck 1987, *Transformation Groups* (?) [1·B] — Studies in Mathematics 8

**Journal papers (15)**

- *J. reine angew. Math. (Crelle)* (13): `AbhyankarMoh1975Embeddings` Abhyankar–Moh 1975, *Embeddings of the line in the plane* (?) [1·A]; `Hall1940Classification` Hall 1940, *Classification of prime-power groups* (?) [1·A]; `Heinrich1980Ultraproducts` Heinrich 1980, *Ultraproducts in Banach space theory* (?) [1·A]; `KirchbergPhillips2000Embedding` Kirchberg–Phillips 2000, *Embedding of exact C*-algebras in the Cuntz algebra O_2* (?) [1·A]; `Muller1990Higher` Müller 1990, *Higher integrability of determinants and weak convergence…* (?) [1·A]; `Strassen1988Asymptotic` Strassen 1988, *Asymptotic spectrum of tensors* (?) [1·A]; `BeauvilleNarasimhanRamanan1989Spectral` Beauville–Narasimhan–Ramanan 1989, *Spectral curves and the generalised theta divisor* (?) [1·B]; `HeathBrownPatterson1979Distribution` Heath-Brown–Patterson 1979, *Distribution of Kummer sums at prime arguments* (?) [1·B]; `KudlaRallis1988Weil` Kudla–Rallis 1988, *Weil-Siegel formula* (?) [1·B]; `Luck1998Dimension` Lück 1998, *Dimension theory of arbitrary modules over finite von…* (?) [1·B]; `Patterson1977Cubic` Patterson 1977, *Cubic analogue of the theta series I, II* (?) [1·B]; `SilvaJerison2009Singular` De Silva–Jerison 2009, *Singular energy minimizing free boundary* (?) [1·B]; `Viehweg1982Vanishing` Viehweg 1982, *Vanishing theorems* (?) [1·B]
- *Forum Math.* (1): `Linnell1993Division` Linnell 1993, *Division rings and group von Neumann algebras* (?) [1·A]
- *Nachr. Akad. Wiss. Göttingen* (?) (1): `Moser1962Invariant` Moser 1962, *Invariant curves of area-preserving mappings of an annulus* (?) [1·B]

### Taylor & Francis (CRC / Chapman & Hall, Pitman / Longman) — 19

**Books (13)**

- `EvansGariepy2015Measure` Evans–Gariepy 2015, *Measure Theory and Fine Properties of Functions* (?) [2·A] — Textbooks in Mathematics, CRC Press
- `ColbournDinitz2007Handbook` Colbourn–Dinitz 2007, *Handbook of Combinatorial Designs* (?) [1·A] — Discrete Mathematics and its Applications, Chapman & Hall/CRC
- `Davidson1988Nest` Davidson 1988, *Nest Algebras* (?) [1·A] — Pitman Research Notes in Mathematics 191, Longman
- `Godsil1993Algebraic` Godsil 1993, *Algebraic Combinatorics* (?) [1·A] — Chapman and Hall
- `Serre1968Abelian` Serre 1968, *Abelian l-adic Representations and Elliptic Curves* [1·A] — W. A. Benjamin (reprint A K Peters 1998)
- `Serre2012Lectures` Serre 2012, *N_X(p)* [1·A] — Research Notes in Mathematics 11, CRC Press
- `BanasGoebel1980Measures` Banaś–Goebel 1980, *Measures of Noncompactness in Banach Spaces* (?) [1·B] — Lecture Notes in Pure and Applied Mathematics 60, Marcel Dekker
- `BeemEhrlichEasley1996Global` Beem–Ehrlich–Easley 1996, *Global Lorentzian Geometry* (?) [1·B] — Monographs and Textbooks in Pure and Applied Mathematics 202, Marcel Dekker
- `Gilkey1995Invariance` Gilkey 1995, *Invariance Theory, the Heat Equation, and the Atiyah–Singer…* (?) [1·B] — Studies in Advanced Mathematics, CRC Press
- `Roe1998Elliptic` Roe 1998, *Elliptic Operators, Topology and Asymptotic Methods* (?) [1·B] — Pitman Research Notes in Mathematics 395, Longman
- `Schaefer2018Crossing` Schaefer 2018, *Crossing Numbers of Graphs* (?) [1·B] — Discrete Mathematics and its Applications, CRC Press
- `Serre2008Topics` Serre 2008, *Galois Theory* (?) [1·B] — Research Notes in Mathematics 1, A K Peters
- `TomczakJaegermann1989Banach` Tomczak-Jaegermann 1989, *Banach–Mazur Distances and Finite-Dimensional Operator…* (?) [1·B] — Pitman Monographs and Surveys in Pure and Applied Mathematics 38, Longman

**Journal papers (4)**

- *Amer. Math. Monthly* (?) (2): `GaleShapley1962College` Gale–Shapley 1962, *College admissions and the stability of marriage* (?) [1·A]; `KuzmanovichPavlichenkov2002Finite` Kuzmanovich–Pavlichenkov 2002, *Finite groups of matrices whose entries are integers* (?) [1·A]
- *Comm. Algebra* (1): `Klyachko1993Funny` Klyachko 1993, *Funny property of sphere and equations over groups* (?) [1·A]
- *Experiment. Math.* (1): `Watkins2002Computing` Watkins 2002, *Computing the modular degree of an elliptic curve* (?) [1·B]

**Other (2)**

- `Schaeffer2015Planar` Schaeffer 2015, *Planar maps* (?) [1·A] — in Handbook of Enumerative Combinatorics (M. Bóna, ed.), CRC Press
- `Brown1986Lidskii` Brown 1986, *Lidskii's theorem in the type II case* (?) [1·B] — in Geometric Methods in Operator Algebras (Kyoto, 1983), Pitman Research Notes in Mathematics 123, Longman, 1–

### ACM — 20

**Journal papers (20)**

- *J. ACM* (10): `BrinkmanCharikar2005Impossibility` Brinkman–Charikar 2005, *Impossibility of dimension reduction in ℓ₁* (?) [2·A]; `AroraRaoVazirani2009Expander` Arora–Rao–Vazirani 2009, *Expander flows, geometric embeddings and graph partitioning* (?) [1·A]; `BansalEtAl2015Polylogarithmic` Bansal et al. 2015, *Polylogarithmic-competitive algorithm for the k-server…* (?) [1·A]; `BealsEtAl2001Quantum` Beals et al. 2001, *Quantum lower bounds by polynomials* (?) [1·A]; `HennieStearns1966Two` Hennie–Stearns 1966, *Two-tape simulation of multitape Turing machines* (?) [1·A]; `KoutsoupiasPapadimitriou1995K` Koutsoupias–Papadimitriou 1995, *K-server conjecture* (?) [1·A]; `HopcroftPaulValiant1977Time` Hopcroft–Paul–Valiant 1977, *Time versus space* (?) [1·B]; `Dinur2007PCP` Dinur 2007, *PCP theorem by gap amplification* (?) [1·C]; `Feige1998Threshold` Feige 1998, *Threshold of ln n for approximating set cover* (?) [1·C]; `Hastad2001Optimal` Håstad 2001, *Some optimal inapproximability results* (?) [1·C]
- *STOC* (9): `BartalEtAl1997Polylog` Bartal et al. 1997, *Polylog(n)-competitive algorithm for metrical task systems* (?) [1·A]; `KarpVaziraniVazirani1990Optimal` Karp–Vazirani–Vazirani 1990, *Optimal algorithm for on-line bipartite matching* (?) [1·A]; `Nisan1991Lower` Nisan 1991, *Lower bounds for non-commutative computation* (?) [1·A]; `CookMertz2024Tree` Cook–Mertz 2024, *Tree evaluation is in space O(log n · log log n)* (?) [1·B]; `ImpagliazzoNisanWigderson1994Pseudorandomness` Impagliazzo–Nisan–Wigderson 1994, *Pseudorandomness for network algorithms* (?) [1·B]; `Williams2025Simulating` Williams 2025, *Simulating time with square-root space* (?) [1·B]; `DinurEtAl2018Towards` Dinur et al. 2018, *Towards a proof of the 2-to-1 games conjecture?* (?) [1·C]; `DinurSteurer2014Analytical` Dinur–Steurer 2014, *Analytical approach to parallel repetition* (?) [1·C]; `Khot2002Power` Khot 2002, *Power of unique 2-prover 1-round games* (?) [1·C]
- *ACM proceedings and journals* (1): `ForsterKunzeRoth2020Weak` Forster–Kunze–Roth 2020, *Weak call-by-value λ-calculus is reasonable for both time…* (?) [1·A]

### Russian Academy of Sciences journals (RAS) — 19

**Journal papers (19)**

- *RAS journals (Izv., Mat. Sb., Uspekhi, Dokl.)* (19): `MerkurjevSuslin1982K` Merkurjev–Suslin 1982, *K-cohomology of Severi–Brauer varieties and the norm…* (?) [2·A]; `Belyi1979Galois` Belyi 1979, *Galois extensions of a maximal cyclotomic field* (?) [1·A]; `BuragoGromovPerelman1992D` Burago–Gromov–Perelman 1992, *A. D. Alexandrov spaces with curvature bounded below* (?) [1·A]; `Danilov1978Geometry` Danilov 1978, *Geometry of toric varieties* (?) [1·A]; `Golod1964Nil` Golod 1964, *Nil-algebras and finitely approximable p-groups* (?) [1·A]; `Kruzkov1970First` Kružkov 1970, *First order quasilinear equations in several independent…* (?) [1·A]; `Nikulin1979Integral` Nikulin 1979, *Integral symmetric bilinear forms and some of their…* [1·A]; `Trofimov1985Graphs` Trofimov 1985, *Graphs with polynomial growth* (?) [1·A]; `Visik1976Non` Višik 1976, *Non-archimedean measures connected with Dirichlet series* (?) [1·A]; `Andrianov1974Euler` Andrianov 1974, *Euler products corresponding to Siegel modular forms of…* (?) [1·B]; `BondalKapranov1989Representable` Bondal–Kapranov 1989, *Representable functors, Serre functors, and mutations* (?) [1·B]; `Lazutkin1973Existence` Lazutkin 1973, *Existence of caustics for a billiard problem in a convex…* (?) [1·B]; `Manin1972Parabolic` Manin 1972, *Parabolic points and zeta functions of modular curves* (?) [1·B]; `Suslin1991K3` Suslin 1991, *K₃ of a field and the Bloch group* (?) [1·B]; `Drinfeld1974Elliptic` Drinfeld 1974, *Elliptic modules* [2·C]; `Manin1963Theory` Manin 1963, *Theory of commutative formal groups over fields of finite…* (?) [1·C]; `NesterenkoSuslin1989Homology` Nesterenko–Suslin 1989, *Homology of the general linear group over a local ring, and…* (?) [1·C]; `Panin2003Equicharacteristic` Panin 2003, *Equicharacteristic case of the Gersten conjecture* (?) [1·C]; `PiatetskiShapiroShafarevich1971Torelli` Piatetski-Shapiro–Shafarevich 1971, *Torelli theorem for algebraic surfaces of type K3* (?) [1·C]

### International Press — 19

**Books (2)**

- `Sogge2008Lectures` Sogge 2008, *Non-Linear Wave Equations* (?) [2·A] — International Press
- `SchoenYau1994Lectures` Schoen–Yau 1994, *Differential Geometry* (?) [1·B] — Conference Proceedings and Lecture Notes in Geometry and Topology I, International Press

**Journal papers (16)**

- *J. Differential Geom.* (14): `Borel1972Metric` Borel 1972, *Some metric properties of arithmetic quotients of symmetric…* [1·A]; `RodinSullivan1987Convergence` Rodin–Sullivan 1987, *Convergence of circle packings to the Riemann mapping* (?) [1·A]; `AtiyahSegal1969Equivariant` Atiyah–Segal 1969, *Equivariant K-theory and completion* (?) [1·B]; `GromollMeyer1969Periodic` Gromoll–Meyer 1969, *Periodic geodesics on compact Riemannian manifolds* (?) [1·B]; `Hitchin1974Compact` Hitchin 1974, *Compact four-dimensional Einstein manifolds* (?) [1·B]; `HuiskenIlmanen2001Inverse` Huisken–Ilmanen 2001, *Inverse mean curvature flow and the Riemannian Penrose…* (?) [1·B]; `Kollar1990Projectivity` Kollár 1990, *Projectivity of complete moduli* (?) [1·B]; `KollarMiyaokaMori1992Rational` Kollár–Miyaoka–Mori 1992, *Rational connectedness and boundedness of Fano manifolds* (?) [1·B]; `Beauville1983Varietes` Beauville 1983, *Variétés kähleriennes dont la première classe de Chern est…* (?) [2·C]; `CheegerColding1997Structure` Cheeger–Colding 1997, *Structure of spaces with Ricci curvature bounded below. I… III* (?) [1·C]; `Donaldson1983Application` Donaldson 1983, *Application of gauge theory to four-dimensional topology* (?) [1·C]; `Donaldson2002Scalar` Donaldson 2002, *Scalar curvature and stability of toric varieties* (?) [1·C]; `FujinoMori2000Canonical` Fujino–Mori 2000, *Canonical bundle formula* (?) [1·C]; `Lu1968Holomorphic` Lu 1968, *Holomorphic mappings of complex manifolds* (?) [1·C]
- *Camb. J. Math.* (1): `Zhang2014Selmer` Zhang 2014, *Selmer groups and the indivisibility of Heegner points* [1·C]
- *Homology Homotopy Appl.* (1): `Steiner2004Omega` Steiner 2004, *Omega-categories and chain complexes* (?) [1·B]

**Other (1)**

- `Diamond1995Refined` Diamond 1995, *Refined conjecture of Serre* (?) [1·C] — Elliptic Curves, Modular Forms, and Fermat's Last Theorem (Hong Kong 1993), International Press, 22-37

### EMS Press — 19

**Books (7)**

- `PayneThas2009Finite` Payne–Thas 2009, *Finite Generalized Quadrangles* (?) [1·A] — Series of Lectures in Mathematics, European Mathematical Society
- `SkowronskiYamagata2011Frobenius` Skowroński–Yamagata 2011, *Frobenius Algebras I* (?) [1·A] — Textbooks in Mathematics
- `DehornoyEtAl2015Foundations` Dehornoy et al. 2015, *Foundations of Garside Theory* (?) [1·B] — Tracts in Mathematics 22, European Mathematical Society
- `GuedjZeriahi2017Degenerate` Guedj–Zeriahi 2017, *Degenerate Complex Monge–Ampère Equations* (?) [1·B] — Tracts in Mathematics 26, European Mathematical Society
- `Ballmann2006Lectures` Ballmann 2006, *Kähler Manifolds* (?) [1·C] — ESI Lectures in Mathematics and Physics, European Mathematical Society
- `Ringstrom2009Cauchy` Ringström 2009, *Cauchy Problem in General Relativity* (?) [1·C] — ESI Lectures in Mathematics and Physics, European Mathematical Society
- `Wehrheim2004Uhlenbeck` Wehrheim 2004, *Uhlenbeck Compactness* (?) [1·C] — Series of Lectures in Mathematics, European Mathematical Society

**Journal papers (12)**

- *Doc. Math.* (?) (7): `GrovesManning2013Virtual` Groves–Manning) 2013, *Virtual Haken conjecture* (?) [1·A]; `BurnsFlach2001Tamagawa` Burns–Flach 2001, *Tamagawa numbers for motives with (non-commutative)…* (?) [1·C]; `CornutVatsal2005CM` Cornut–Vatsal 2005, *CM points and quaternion algebras* (?) [1·C]; `Hsieh2014Special` Hsieh 2014, *Special values of anticyclotomic Rankin-Selberg L-functions* (?) [1·C]; `Jardine2000Motivic` Jardine 2000, *Motivic symmetric spectra* (?) [1·C]; `Voevodsky1998A1` Voevodsky 1998, *A¹-homotopy theory* (?) [1·C]; `Voevodsky2010Cancellation` Voevodsky 2010, *Cancellation theorem* (?) [1·C]
- *J. Eur. Math. Soc.* (2): `LiebeckEtAl2010Ore` Liebeck et al. 2010, *Ore conjecture* (?) [1·A]; `Faltings2003Algebraic` Faltings 2003, *Algebraic loop groups and moduli spaces of bundles* (?) [1·C]
- *Publ. RIMS* (?) (2): `Fujiki1978Closedness` Fujiki 1978, *Closedness of the Douady spaces of compact Kähler spaces* (?) [1·B]; `Kashiwara1984Riemann` Kashiwara 1984, *Riemann–Hilbert problem for holonomic systems* (?) [1·B]
- *Rev. Mat. Iberoam.* (1): `Wolff1995Improved` Wolff 1995, *Improved bound for Kakeya type maximal functions* (?) [1·A]

### Duke University Press — 18

**Journal papers (18)**

- *Duke Math. J.* (11): `Nakajima1994Instantons` Nakajima 1994, *Instantons on ALE spaces, quiver varieties, and Kac–Moody…* (?) [1·A]; `PilaWilkie2006Rational` Pila–Wilkie 2006, *Rational points of a definable set* (?) [1·A]; `Powers1975Simplicity` Powers 1975, *Simplicity of the C*-algebra associated with the free group…* (?) [1·A]; `StoneTukey1942Generalized` Stone–Tukey 1942, *Generalized "sandwich" theorems* (?) [1·A]; `Arthur1978Trace` Arthur 1978, *Trace formula for reductive groups I* (?) [1·B]; `GanYu2000Group` Gan–Yu 2000, *Group schemes and local densities* (?) [1·B]; `Hitchin1987Stable` Hitchin 1987, *Stable bundles and integrable systems* (?) [1·B]; `Shimura1978Special` Shimura 1978, *Special values of the zeta functions associated with…* (?) [1·B]; `Anderson1986T` Anderson 1986, *t-motives* [1·C]; `BertoliniDarmonPrasanna2013Generalized` Bertolini–Darmon–Prasanna 2013, *Generalized Heegner cycles and p-adic Rankin L-series* (?) [1·C]; `Mackey1949Theorem` Mackey 1949, *Theorem of Stone and von Neumann* (?) [1·C]
- *J. Math. Kyoto Univ. / Kyoto J. Math.* (?) (4): `MiyanishiSugie1980Affine` Miyanishi–Sugie 1980, *Affine surfaces containing cylinderlike open sets* (?) [1·A]; `Mumford1968Rational` Mumford 1968, *Rational equivalence of 0-cycles on surfaces* (?) [1·A]; `Nagata1964Invariants` Nagata 1964, *Invariants of a group in an affine ring* (?) [1·A]; `KatzOda1968Differentiation` Katz–Oda 1968, *Differentiation of de Rham cohomology classes with respect…* (?) [1·C]
- *Illinois J. Math.* (?) (3): `Pardue1996Deformation` Pardue 1996, *Deformation classes of graded modules and maximal Betti…* (?) [1·A]; `Wohlfahrt1964Extension` Wohlfahrt 1964, *Extension of F. Klein's level concept* [1·A]; `RosserSchoenfeld1962Approximate` Rosser–Schoenfeld 1962, *Approximate formulas for some functions of prime numbers* (?) [1·C]

### SIAM — 15

**Books (3)**

- `BlekhermanParriloThomas2013Semidefinite` Blekherman–Parrilo–Thomas 2013, *Semidefinite Optimization and Convex Algebraic Geometry* (?) [1·A] — MOS-SIAM Series on Optimization 13, SIAM
- `MooreKearfottCloud2009Interval` Moore–Kearfott–Cloud 2009, *Interval Analysis* (?) [1·A] — SIAM
- `Glassey1996Cauchy` Glassey 1996, *Cauchy Problem in Kinetic Theory* (?) [1·B] — SIAM

**Journal papers (12)**

- *SIAM journals* (12): `AaronsonAmbainis2018Forrelation` Aaronson–Ambainis 2018, *Forrelation* (?) [1·A]; `AdlemanDeMarraisHuang1997Quantum` Adleman–DeMarrais–Huang 1997, *Quantum computability* (?) [1·A]; `CaludeEtAl2022Deciding` Calude et al. 2022, *Deciding parity games in quasi-polynomial time* (?) [1·A]; `Chaiken1982Combinatorial` Chaiken 1982, *Combinatorial proof of the all minors matrix tree theorem* (?) [1·A]; `Gillman1998Chernoff` Gillman 1998, *Chernoff bound for random walks on expander graphs* (?) [1·A]; `KempeKitaevRegev2006Complexity` Kempe–Kitaev–Regev 2006, *Complexity of the local Hamiltonian problem* (?) [1·A]; `Lasserre2001Global` Lasserre 2001, *Global optimization with polynomials and the problem of…* (?) [1·A]; `SchroeppelShamir1981T` Schroeppel–Shamir 1981, *T = O(2^{n/2}), S = O(2^{n/4}) algorithm for certain…* (?) [1·B]; `KhotEtAl2007Optimal` Khot et al. 2007, *Optimal inapproximability results for MAX-CUT and other…* (?) [1·C]; `Rao2011Parallel` Rao 2011, *Parallel repetition in projection games and a concentration…* (?) [1·C]; `Raz1998Parallel` Raz 1998, *Parallel repetition theorem* (?) [1·C]; `RubinfeldSudan1996Robust` Rubinfeld–Sudan 1996, *Robust characterizations of polynomials with applications…* (?) [1·C]

### London Mathematical Society (Oxford University Press, Wiley) — 15

**Journal papers (15)**

- *LMS journals* (?) (14): `BaranyShlosmanSzucs1981Topological` Bárány–Shlosman–Szűcs 1981, *Topological generalization of a theorem of Tverberg* (?) [1·A]; `KnorrRobinson1989Remarks` Knörr–Robinson 1989, *Some remarks on a conjecture of Alperin* (?) [1·A]; `KomlosPintzSzemeredi1982Lower` Komlós–Pintz–Szemerédi 1982, *Lower bound for Heilbronn's problem* (?) [1·A]; `Promislow1988Simple` Promislow 1988, *Simple example of a torsion-free, non unique product group* (?) [1·A]; `Ranicki1980Algebraic` Ranicki 1980, *Algebraic theory of surgery I, II* (?) [1·A]; `Rickard1989Morita` Rickard 1989, *Morita theory for derived categories* (?) [1·A]; `Hitchin1987Self` Hitchin 1987, *Self-duality equations on a Riemann surface* (?) [2·B]; `HeathBrown1992Zero` Heath-Brown 1992, *Zero-free regions for Dirichlet L-functions, and the least…* (?) [1·B]; `MandellEtAl2001Model` Mandell et al. 2001, *Model categories of diagram spectra* (?) [1·B]; `Nitsure1991Moduli` Nitsure 1991, *Moduli space of semistable pairs on a curve* (?) [1·B]; `Okikiolu1992Characterization` Okikiolu 1992, *Characterization of subsets of rectifiable curves in ℝⁿ* (?) [1·B]; `Rademacher1937Partition` Rademacher 1937, *Partition function p(n)* (?) [1·B]; `Scott1983Geometries` Scott 1983, *Geometries of 3-manifolds* (?) [1·B]; `BushnellKutzko1998Smooth` Bushnell–Kutzko 1998, *Smooth representations of reductive p-adic groups* (?) [1·C]
- *J. Topol.* (1): `Weibel2009Norm` Weibel 2009, *Norm residue isomorphism theorem* (?) [1·C]

### Mathematical Society of Japan (MSJ) — 13

**Books (3)**

- `Fujino2017Foundations` Fujino 2017, *Foundations of the Minimal Model Program* (?) [2·A] — MSJ Memoirs 35, Math. Soc. Japan
- `Kubota1969Automorphic` Kubota 1969, *Automorphic Functions and the Reciprocity Law in a Number…* (?) [1·B] — Lectures in Mathematics, Department of Mathematics, Kyoto University 2, Kinokuniya
- `Nakayama2004Zariski` Nakayama 2004, *Zariski-Decomposition and Abundance* (?) [1·B] — MSJ Memoirs 14, Math. Soc. Japan

**Journal papers (3)**

- *J. Math. Soc. Japan* (3): `Uchida1976Isomorphisms` Uchida 1976, *Isomorphisms of Galois groups* [1·A]; `Honda1968Isogeny` Honda 1968, *Isogeny classes of abelian varieties over finite fields* [1·B]; `Fujita1978Kahler` Fujita 1978, *Kähler fiber spaces over curves* (?) [1·C]

**Other (7)**

- `Greenberg1989Iwasawa` Greenberg 1989, *Iwasawa theory for p-adic representations* [1·A] — Algebraic Number Theory, Adv. Stud. Pure Math. 17, Academic Press, 97-137
- `Grothendieck1968Groupe` Grothendieck 1968, *Le groupe de Brauer III* [1·A] — in Dix exposés sur la cohomologie des schémas, North-Holland, 88–188
- `ChoMiyaokaShepherdBarron2002Characterizations` Cho–Miyaoka–Shepherd-Barron 2002, *Characterizations of projective space and applications to…* (?) [1·B] — in Higher Dimensional Birational Geometry, Adv. Stud. Pure Math. 35, 1–88
- `Kato1978Compact` Kato 1978, *Compact complex manifolds containing 'global' spherical… I* (?) [1·B] — in Proc. Int. Symp. Algebraic Geometry (Kyoto 1977), Kinokuniya, 45–84
- `Fujiki1987Rham` Fujiki 1987, *De Rham cohomology group of a compact Kähler symplectic…* (?) [1·C] — in Algebraic Geometry (Sendai 1985), Adv. Stud. Pure Math. 10, 105–165
- `KawamataMatsudaMatsuki1987Minimal` Kawamata–Matsuda–Matsuki 1987, *Minimal model problem* (?) [1·C] — in Algebraic Geometry (Sendai 1985), Adv. Stud. Pure Math. 10, 283–360
- `Viehweg1983Weak` Viehweg 1983, *Weak positivity and the additivity of the Kodaira dimension…* (?) [1·C] — in Algebraic Varieties and Analytic Varieties, Adv. Stud. Pure Math. 1, 329–353

### Centre Mersenne (open access) — 12

**Journal papers (12)**

- *Ann. Inst. Fourier* (7): `Buchdahl1999Compact` Buchdahl 1999, *Compact Kähler surfaces* (?) [1·B]; `Campana2004Orbifolds` Campana 2004, *Orbifolds, special varieties and classification theory* (?) [1·B]; `Douady1966Probleme` Douady 1966, *Le problème des modules pour les sous-espaces analytiques…* (?) [1·B]; `EinEtAl2006Asymptotic` Ein et al. 2006, *Asymptotic invariants of base loci* (?) [1·B]; `HoweNartRitzenthaler2009Jacobians` Howe–Nart–Ritzenthaler 2009, *Jacobians in isogeny classes of abelian surfaces over…* (?) [1·B]; `Lamari1999Courants` Lamari 1999, *Courants kählériens et surfaces compactes* (?) [1·B]; `Hausberger2005Uniformisation` Hausberger 2005, *Uniformisation des variétés de Laumon-Rapoport-Stuhler et…* [1·C]
- *Ann. Fac. Sci. Toulouse* (1): `Paris2014K` Paris 2014, *K(π,1) conjecture for Artin groups* (?) [1·B]
- *Cahiers Topol. Géom. Différ.* (?) (1): `Thomason1980Cat` Thomason 1980, *Cat as a closed model category* (?) [1·A]
- *Confluentes Math.* (?) (1): `Andre2009Slope` André 2009, *Slope filtrations* (?) [1·B]
- *J. Théor. Nombres Bordeaux* (1): `MazurRubin2016Controlling` Mazur–Rubin 2016, *Controlling Selmer groups in the higher core rank case* (?) [1·B]
- *J. Éc. polytech. Math.* (1): `PhilippisGigli2018Non` De Philippis–Gigli 2018, *Non-collapsed spaces with Ricci curvature bounded from below* (?) [1·C]

### Institute of Mathematical Statistics — 10

**Journal papers (10)**

- *IMS journals* (10): `AldousLyons2007Processes` Aldous–Lyons 2007, *Processes on unimodular random networks* (?) [1·A]; `BoueDupuis1998Variational` Boué–Dupuis 1998, *Variational representation for certain functionals of…* (?) [1·A]; `Ferguson1989Who` Ferguson 1989, *Who solved the secretary problem?* (?) [1·A]; `Nolin2008Near` Nolin 2008, *Near-critical percolation in two dimensions* (?) [1·A]; `SamuelCahn1984Comparison` Samuel-Cahn 1984, *Comparison of threshold stop rules and maximum for…* (?) [1·A]; `AbrahamDelmasHoscheit2013Note` Abraham–Delmas–Hoscheit 2013, *Note on the Gromov–Hausdorff–Prokhorov distance between…* (?) [1·B]; `Aldous1993Continuum` Aldous 1993, *Continuum random tree. III* (?) [1·B]; `EvansEtAl2000Broadcasting` Evans et al. 2000, *Broadcasting on trees and the Ising model* (?) [1·B]; `Gall2005Random` Le Gall 2005, *Random trees and applications* (?) [1·B]; `Janson2012Simply` Janson 2012, *Simply generated trees, conditioned Galton–Watson trees…* (?) [1·B]

### World Scientific — 8

**Books (5)**

- `BumpSchilling2017Crystal` Bump–Schilling 2017, *Crystal Bases* (?) [1·A] — —
- `Giusti2003Direct` Giusti 2003, *Direct Methods in the Calculus of Variations* (?) [1·A] — —
- `KacRaina1987Bombay` Kac–Raina 1987, *Bombay Lectures on Highest Weight Representations of…* (?) [1·A] — Advanced Series in Mathematical Physics 2
- `Almgren2000Almgren` Almgren 2000, *Almgren's Big Regularity Paper* (?) [1·B] — Monograph Series in Mathematics 1
- `Weaver2018Lipschitz` Weaver 2018, *Lipschitz Algebras* (?) [1·B] — —

**Journal papers (3)**

- *Int. J. (World Scientific)* (2): `FeiginFrenkel1992Affine` Feigin–Frenkel 1992, *Affine Kac–Moody algebras at the critical level and…* (?) [1·A]; `Bangert1993Existence` Bangert 1993, *Existence of closed geodesics on two-spheres* (?) [1·B]
- *Rev. Math. Phys.* (1): `ArakiZsido2005Extension` Araki–Zsidó 2005, *Extension of the structure theorem of Borchers and its…* (?) [1·B]

### University of Chicago Press — 7

**Books (7)**

- `Katok1992Fuchsian` Katok 1992, *Fuchsian Groups* [2·A] — Chicago Lectures in Mathematics, University of Chicago Press
- `Harpe2000Topics` de la Harpe 2000, *Geometric Group Theory* (?) [1·A] — Chicago Lectures in Mathematics, University of Chicago Press
- `Adams1974Stable` Adams 1974, *Stable Homotopy and Generalised Homology* (?) [3·B] — Chicago Lectures in Mathematics, University of Chicago Press
- `Eberlein1996Geometry` Eberlein 1996, *Geometry of Nonpositively Curved Manifolds* (?) [1·B] — Chicago Lectures in Mathematics, University of Chicago Press
- `Kaplansky1969Fields` Kaplansky 1969, *Fields and Rings* (?) [1·B] — Chicago Lectures in Mathematics, University of Chicago Press
- `Pesin1997Dimension` Pesin 1997, *Dimension Theory in Dynamical Systems* (?) [1·B] — Chicago Lectures in Mathematics, University of Chicago Press
- `Wald1984General` Wald 1984, *General Relativity* (?) [1·B] — University of Chicago Press

### MSP — 7

**Journal papers (7)**

- *Pacific J. Math.* (4): `Wongkew1993Volumes` Wongkew 1993, *Volumes of tubular neighbourhoods of real algebraic…* (?) [1·A]; `Dykema1994Interpolated` Dykema 1994, *Interpolated free group factors* (?) [1·B]; `RangaRao1993Explicit` Ranga Rao 1993, *Some explicit formulas in the theory of Weil representation* (?) [1·B]; `Schwarz2000Action` Schwarz 2000, *Action spectrum for closed symplectically aspherical…* (?) [1·B]
- *Algebr. Geom. Topol.* (1): `Waldhausen1985Algebraic` Waldhausen 1985, *Algebraic K-theory of spaces* (?) [1·B]
- *Algebra Number Theory* (1): `Baker2008Specialization` Baker 2008, *Specialization of linear systems from curves to graphs* (?) [1·A]
- *Geom. Topol.* (1): `Bridson2002Geometry` Bridson 2002, *Geometry of the word problem* (?) [1·A]

### National Academy of Sciences — 6

**Journal papers (6)**

- *Proc. Natl. Acad. Sci. USA* (6): `Weil1948Exponential` Weil 1948, *Some exponential sums* [2·A]; `GerstenhaberRothaus1962Solution` Gerstenhaber–Rothaus 1962, *Solution of sets of equations in groups* (?) [1·A]; `Stein1976Maximal` Stein 1976, *Maximal functions. I. Spherical means* (?) [1·A]; `Adem1952Iteration` Adem 1952, *Iteration of the Steenrod squares in algebraic topology* (?) [1·B]; `Kodaira1953Differential` Kodaira 1953, *Differential-geometric method in the theory of analytic…* (?) [1·B]; `Yau1977Calabi` Yau 1977, *Calabi's conjecture and some new results in algebraic…* (?) [1·B]

### Pearson (Addison-Wesley, Prentice Hall, Benjamin) — 4

**Books (4)**

- `DoCarmo1976Differential` do Carmo 1976, *Differential Geometry of Curves and Surfaces* (?) [2·A] — Prentice-Hall (2nd ed. Dover, 2016)
- `Bass1968Algebraic` Bass 1968, *Algebraic K-Theory* (?) [1·A] — W. A. Benjamin
- `Atiyah1967K` Atiyah 1967, *K-Theory* (?) [1·B] — W. A. Benjamin (reprinted Addison-Wesley 1989)
- `Ruelle1969Statistical` Ruelle 1969, *Statistical Mechanics* (?) [1·B] — W. A. Benjamin

### Hermann (Paris) — 6

**Books (5)**

- `Serre1979Local` Serre 1979, *Local Fields* [5·A] — Graduate Texts in Mathematics 67
- `Serre1977Linear` Serre 1977, *Linear Representations of Finite Groups* [3·A] — Graduate Texts in Mathematics 42
- `Borel1969Aux` Borel 1969, *Introduction aux Groupes Arithmétiques* [2·A] — Hermann
- `Ecalle1992Aux` Écalle 1992, *Introduction aux fonctions analysables et preuve…* (?) [1·A] — Hermann
- `Weil1948Courbes` Weil 1948, *Sur les courbes algébriques et les variétés qui s'en…* (?) [1·C] — Actualités Sci. Ind. 1041, Hermann

**Other (1)**

- `Bernstein1984Centre` Bernstein 1984, *Le « centre » de Bernstein* (?) [1·A] — Représentations des groupes réductifs sur un corps local, Travaux en Cours, Hermann, 1–32

### Schloss Dagstuhl (LIPIcs) — 5

**Journal papers (5)**

- *LIPIcs* (5): `BayerEtAl2019DPRM` Bayer et al. 2019, *DPRM theorem in Isabelle (short paper)* (?) [1·A]; `DahmenHolzlLewis2019Formalizing` Dahmen–Hölzl–Lewis 2019, *Formalizing the solution to the cap set problem* (?) [1·A]; `DellGroheRattan2018Lovasz` Dell–Grohe–Rattan 2018, *Lovász meets Weisfeiler and Leman* (?) [1·A]; `DilliesMehta2022Formalising` Dillies–Mehta 2022, *Formalising Szemerédi's Regularity Lemma in Lean* (?) [1·A]; `GaherKunze2021Mechanising` Gäher–Kunze 2021, *Mechanising complexity theory* (?) [1·B]

### University of Michigan — 5

**Journal papers (5)**

- *Michigan Math. J.* (5): `Eggan1963Transition` Eggan 1963, *Transition graphs and the star-height of regular events* (?) [1·A]; `Steenrod1967Convenient` Steenrod 1967, *Convenient category of topological spaces* [1·A]; `BorelMoore1960Homology` Borel–Moore 1960, *Homology theory for locally compact spaces* (?) [1·B]; `BrownNeumann1977Proof` Brown–Neumann 1977, *Proof of the Poincaré–Birkhoff fixed point theorem* (?) [1·B]; `Yang1960P` Yang 1960, *p-adic transformation groups* (?) [1·B]

### IEEE (IBM) — 4

**Journal papers (4)**

- *IEEE proceedings and journals* (2): `KahnKalaiLinial1988Influence` Kahn–Kalai–Linial 1988, *Influence of variables on Boolean functions* (?) [1·A]; `Lovasz1979Shannon` Lovász 1979, *Shannon capacity of a graph* (?) [1·A]
- *CCC* (1): `CleveEtAl2004Consequences` Cleve et al. 2004, *Consequences and limits of nonlocal strategies* (?) [1·A]
- *IBM J. Res. Develop.* (?) (1): `Shepherdson1959Reduction` Shepherdson 1959, *Reduction of two-way automata to one-way automata* (?) [1·A]

### American Physical Society — 5

**Journal papers (5)**

- *APS journals* (5): `KacWard1952Combinatorial` Kac–Ward 1952, *Combinatorial solution of the two-dimensional Ising model* (?) [1·B]; `Coleman1963Structure` Coleman 1963, *Structure of fermion density matrices* (?) [1·C]; `Laughlin1983Anomalous` Laughlin 1983, *Anomalous quantum Hall effect* (?) [1·C]; `Lieb1984Bound` Lieb 1984, *Bound on the maximum negative ionization of atoms and…* (?) [1·C]; `TrugmanKivelson1985Exact` Trugman–Kivelson 1985, *Exact results for the fractional quantum Hall effect with…* (?) [1·C]

### McGraw-Hill — 2

**Books (2)**

- `Ahlfors1979Complex` Ahlfors 1979, *Complex Analysis* (?) [1·A] — McGraw-Hill
- `Rudin1987Real` Rudin 1987, *Real and Complex Analysis* (?) [1·A] — McGraw-Hill

### Université de Genève — 3

**Journal papers (3)**

- *L'Enseign. Math.* (?) (3): `Alperin1987Elementary` Alperin 1987, *Elementary account of Selberg's lemma* (?) [1·A]; `CannonFloydParry1996Introductory` Cannon–Floyd–Parry 1996, *Introductory notes on Richard Thompson's groups* (?) [1·A]; `Venkov2001Reseaux` Venkov 2001, *Réseaux et designs sphériques* (?) [1·B]

### Tokyo Institute of Technology — 3

**Journal papers (3)**

- *Kodai Math. J.* (3): `Artin1969Algebraization` Artin 1969, *Algebraization of formal moduli I* [1·A]; `Fujita1994Approximating` Fujita 1994, *Approximating Zariski decomposition of big line bundles* (?) [1·B]; `Mumford1969Enriques` Mumford 1969, *Enriques' classification of surfaces in char p* (?) [1·B]

### AIP Publishing — 3

**Journal papers (3)**

- *J. Math. Phys.* (3): `Glassey1977Blowing` Glassey 1977, *Blowing up of solutions to the Cauchy problem for nonlinear…* (?) [1·A]; `LebowitzPenrose1966Rigorous` Lebowitz–Penrose 1966, *Rigorous treatment of the van der Waals–Maxwell theory of…* (?) [1·B]; `BisognanoWichmann1975Duality` Bisognano–Wichmann 1975, *Duality condition for a Hermitian scalar field* (?) [1·C]

### MIT Press — 1

**Books (1)**

- `GusfieldIrving1989Stable` Gusfield–Irving 1989, *Stable Marriage Problem* (?) [1·A] — MIT Press

### Mathematica Scandinavica — 3

**Journal papers (3)**

- *Math. Scand.* (3): `Ehrhard1983Symetrisation` Ehrhard 1983, *Symétrisation dans l'espace de Gauss* (?) [1·A]; `Jonsson1967Algebras` Jónsson 1967, *Algebras whose congruence lattices are distributive* (?) [1·A]; `Knudsen1983Projectivity` Knudsen 1983, *Projectivity of the moduli space of stable curves II* [1·B]

### Indiana University — 3

**Journal papers (3)**

- *Indiana Univ. Math. J.* (3): `Garding1959Inequality` Gårding 1959, *Inequality for hyperbolic polynomials* (?) [1·A]; `Putinar1993Positive` Putinar 1993, *Positive polynomials on compact semi-algebraic sets* (?) [1·A]; `GarofaloLin1986Monotonicity` Garofalo–Lin 1986, *Monotonicity properties of variational integrals, A_p…* (?) [1·B]

### Polish Academy of Sciences (IMPAN) — 3

**Journal papers (3)**

- *IMPAN journals* (3): `KnasterKuratowskiMazurkiewicz1929Beweis` Knaster et al. 1929, *Ein Beweis des Fixpunktsatzes für n-dimensionale Simplexe* (?) [1·A]; `GodefroyKalton2003Lipschitz` Godefroy–Kalton 2003, *Lipschitz-free Banach spaces* (?) [1·B]; `MaureyPisier1976Series` Maurey–Pisier 1976, *Séries de variables aléatoires vectorielles indépendantes…* (?) [1·B]

### Dover — 1

**Books (1)**

- `Bollobas1978Extremal` Bollobás 1978, *Extremal Graph Theory* (?) [1·A] — LMS Monographs 11; reprinted Dover 2004

### Royal Society — 2

**Journal papers (2)**

- *Proc. R. Soc. / Phil. Trans.* (2): `ConwaySloane1988Low` Conway–Sloane 1988, *Low-dimensional lattices IV* [1·B]; `DavenportHeilbronn1971Density` Davenport–Heilbronn 1971, *Density of discriminants of cubic fields II* (?) [1·B]

### Hindustan Book Agency / TRIM (Hindustan Book Agency / TIFR) — 2

**Books (1)**

- `Mumford1974Abelian` Mumford 1974, *Abelian Varieties* [3·A] — Tata Institute Studies in Mathematics 5 (corrected reprint Hindustan Book Agency 2008)

**Other (1)**

- `Deligne2007Categorie` Deligne 2007, *La catégorie des représentations du groupe symétrique S_t…* (?) [1·B] — Algebraic Groups and Homogeneous Spaces, TIFR Studies in Mathematics 19, 209–273

### IOP Publishing — 2

**Journal papers (2)**

- *Inverse Problems* (2): `EskinRalston2002Inverse` Eskin–Ralston 2002, *Inverse boundary value problem for linear isotropic…* (?) [1·B]; `Uhlmann2009Electrical` Uhlmann 2009, *Electrical impedance tomography and Calderón's problem* (?) [1·B]

### Cengage (Wadsworth, Brooks/Cole) — 2

**Books (2)**

- `McKenzieMcNultyTaylor1987Algebras` McKenzie–McNulty–Taylor 1987, *Algebras, Lattices, Varieties, Vol. I* (?) [1·A] — Wadsworth & Brooks/Cole
- `Garrett1990Holomorphic` Garrett 1990, *Holomorphic Hilbert Modular Forms* (?) [1·B] — Wadsworth & Brooks/Cole

### University of Tokyo — 2

**Journal papers (2)**

- *J. Fac. Sci., Univ. Tokyo, Sect. I A* (?) (1): `Ihara1981Remarks` Ihara 1981, *Some remarks on the number of rational points of algebraic…* [1·A]
- *J. Math. Sci. Univ. Tokyo* (1): `Mochizuki1996Profinite` Mochizuki 1996, *Profinite Grothendieck conjecture for closed hyperbolic…* (?) [1·C]

### Tohoku University — 1

**Journal papers (1)**

- *Tôhoku Math. J.* (1): `ConnesTakesaki1977Flow` Connes–Takesaki 1977, *Flow of weights on factors of type III* (?) [1·B]

### Japan Academy — 1

**Journal papers (1)**

- *Proc. Japan Acad.* (1): `Fujita1979Zariski` Fujita 1979, *Zariski problem* (?) [1·A]

### Academic Publications (Sofia) — 1

**Journal papers (1)**

- *Int. J. Pure Appl. Math.* (?) (1): `MakinoBerz2003Taylor` Makino–Berz 2003, *Taylor models and other validated functional inclusion…* (?) [1·A]

### CNRS (Paris) — 1

**Journal papers (1)**

- *Colloq. Int. CNRS* (1): `Krasner1966Nombre` Krasner 1966, *Nombre des extensions d'un degré donné d'un corps p-adique* [2·A]

### DARBA (Sofia) — 1

**Journal papers (1)**

- *East J. Approx.* (?) (1): `Antonov1996Convergence` Antonov 1996, *Convergence of Fourier series* (?) [1·B]

### Editura Academiei / Abacus Press — 1

**Books (1)**

- `Stratila1981Modular` Strătilă 1981, *Modular Theory in Operator Algebras* (?) [1·B] — Editura Academiei (Bucharest) and Abacus Press (Tunbridge Wells)

### Edizioni della Normale (Pisa) — 1

**Books (1)**

- `Cheeger2001Degeneration` Cheeger 2001, *Degeneration of Riemannian Metrics under Ricci Curvature…* (?) [1·C] — Lezioni Fermiane, Scuola Normale Superiore, Pisa

### Electronic Journal of Combinatorics (open access) — 2

**Journal papers (2)**

- *Electron. J. Combin.* (2): `KenyonProppWilson2000Trees` Kenyon–Propp–Wilson 2000, *Trees and matchings* (?) [2·A]; `Gurvits2008Van` Gurvits 2008, *Van der Waerden/Schrijver–Valiant like conjectures and…* (?) [1·A]

### Harvard University Press — 1

**Books (1)**

- `McCoyWu1973Two` McCoy–Wu 1973, *Two-Dimensional Ising Model* (?) [1·B] — Harvard University Press

### Independent University of Moscow — 2

**Journal papers (2)**

- *Moscow Math. J.* (?) (2): `BondalBergh2003Generators` Bondal–van den Bergh 2003, *Generators and representability of functors in commutative…* (?) [1·A]; `Deligne2002Categories` Deligne 2002, *Catégories tensorielles* (?) [1·B]

### Indian Mathematical Society — 1

**Journal papers (1)**

- *J. Indian Math. Soc.* (1): `Selberg1954Note` Selberg 1954, *Note on a paper by L. G. Sathe* [1·A]

### Oliver & Boyd (defunct) — 1

**Books (1)**

- `Akhiezer1965Classical` Akhiezer 1965, *Classical Moment Problem and Some Related Questions in…* (?) [1·B] — Oliver & Boyd (English translation)

### Open access (Discrete Analysis) — 1

**Journal papers (1)**

- *Discrete Anal.* (1): `Rao2020Coding` Rao 2020, *Coding for sunflowers* (?) [1·A]

### Open access (Mount Allison University) — 1

**Journal papers (1)**

- *Theory Appl. Categ.* (1): `Henry2020Weak` Henry 2020, *Weak model categories in classical and constructive…* (?) [1·B]

### Open access (Theory of Computing) — 1

**Journal papers (1)**

- *Theory Comput.* (1): `Holenstein2009Parallel` Holenstein 2009, *Parallel repetition* (?) [1·C]

### Philips Research (print only) — 1

**Journal papers (1)**

- *Philips Res. Rep.* (1): `Delsarte1973Algebraic` Delsarte 1973, *Algebraic approach to the association schemes of coding…* (?) [1·A]

### Quart. J. Pure Appl. Math. (historical, print only) — 1

**Journal papers (1)**

- *Quart. J. Pure Appl. Math. (historical)* (1): `HardyRamanujan1917Normal` Hardy–Ramanujan 1917, *Normal number of prime factors of a number n* [1·A]

### Ramanujan Mathematical Society — 1

**Journal papers (1)**

- *J. Ramanujan Math. Soc.* (1): `Conrad2007Deligne` Conrad 2007, *Deligne's notes on Nagata compactifications* (?) [1·A]

### Theta Foundation (Bucharest) — 2

**Journal papers (2)**

- *J. Operator Theory* (2): `Kirchberg1996Derivation` Kirchberg 1996, *Derivation problem and the similarity problem are equivalent* (?) [1·A]; `PimsnerVoiculescu1982K` Pimsner–Voiculescu 1982, *K-groups of reduced crossed products by free groups* (?) [1·B]

### Van Nostrand (defunct; reprints vary) — 1

**Books (1)**

- `CollingwoodMcGovern1993Nilpotent` Collingwood–McGovern 1993, *Nilpotent Orbits in Semisimple Lie Algebras* (?) [1·B] — Van Nostrand Reinhold

## (c) Purchase items by publisher

54 works the compilers marked `purchase` (no library copy expected; mostly LTCS textbooks).

- **Springer Nature** (19): `KechrisMiller2004Topics` Kechris–Miller 2004, *Orbit Equivalence* (?) [2·A] — Lecture Notes in Mathematics 1852; `Burgisser2000Completeness` Bürgisser 2000, *Completeness and Reduction in Algebraic Complexity Theory* (?) [1·A] — Algorithms and Computation in Mathematics 7; `BurgisserClausenShokrollahi1997Algebraic` Bürgisser–Clausen–Shokrollahi 1997, *Algebraic Complexity Theory* (?) [1·A] — Grundlehren der mathematischen Wissenschaften 315; `EbbinghausFlumThomas2021Mathematical` Ebbinghaus–Flum–Thomas 2021, *Mathematical Logic* (?) [1·A] — Graduate Texts in Mathematics 291; `FilarVrieze1997Competitive` Filar–Vrieze 1997, *Competitive Markov Decision Processes* (?) [1·A] — —; `GradelThomasWilke2002Automata` Grädel–Thomas–Wilke 2002, *Automata, Logics, and Infinite Games* (?) [1·A] — LNCS 2500; `Immerman1999Descriptive` Immerman 1999, *Descriptive Complexity* (?) [1·A] — Graduate Texts in Computer Science; `Jech2003Set` Jech 2003, *Set Theory* (?) [1·A] — Monographs in Mathematics; `Kechris1995Classical` Kechris 1995, *Classical Descriptive Set Theory* (?) [1·A] — Graduate Texts in Mathematics 156; `Lerman1983Degrees` Lerman 1983, *Degrees of Unsolvability* (?) [1·A] — Perspectives in Mathematical Logic; `Libkin2004Elements` Libkin 2004, *Finite Model Theory* (?) [1·A] — Texts in Theoretical Computer Science; `Marker2002Model` Marker 2002, *Model Theory* (?) [1·A] — Graduate Texts in Mathematics 217; `Soare1987Recursively` Soare 1987, *Recursively Enumerable Sets and Degrees* (?) [1·A] — Perspectives in Mathematical Logic; `Soare2016Turing` Soare 2016, *Turing Computability* (?) [1·A] — Theory and Applications of Computability; `Straubing1994Finite` Straubing 1994, *Finite Automata, Formal Logic, and Circuit Complexity* (?) [1·A] — Progress in Theoretical Computer Science; `AusielloEtAl1999Complexity` Ausiello et al. 1999, *Complexity and Approximation* (?) [1·B] — —; `GrotschelLovaszSchrijver1988Geometric` Grötschel–Lovász–Schrijver 1988, *Geometric Algorithms and Combinatorial Optimization* (?) [1·B] — Algorithms and Combinatorics 2; `Jukna2012Boolean` Jukna 2012, *Boolean Function Complexity* (?) [1·B] — Algorithms and Combinatorics 27; `Nussbaumer1982Fast` Nussbaumer 1982, *Fast Fourier Transform and Convolution Algorithms* (?) [1·B] — Series in Information Sciences 2
- **Cambridge University Press** (15): `AroraBarak2009Computational` Arora–Barak 2009, *Computational Complexity* (?) [6·A] — —; `Goldreich2008Computational` Goldreich 2008, *Computational Complexity* (?) [2·A] — —; `MotwaniRaghavan1995Randomized` Motwani–Raghavan 1995, *Randomized Algorithms* (?) [2·A] — —; `Beck2008Combinatorial` Beck 2008, *Combinatorial Games* (?) [1·A] — Encyclopedia of Mathematics and its Applications 114; `BeckerKechris1996Descriptive` Becker–Kechris 1996, *Descriptive Set Theory of Polish Group Actions* (?) [1·A] — LMS Lecture Note Series 232; `BorodinElYaniv1998Online` Borodin–El-Yaniv 1998, *Online Computation and Competitive Analysis* (?) [1·A] — —; `CsiszarKorner2011Information` Csiszár–Körner 2011, *Information Theory* (?) [1·A] — —; `Dries1998Tame` van den Dries 1998, *Tame Topology and o-minimal Structures* (?) [1·A] — LMS Lecture Note Series 248; `Grohe2017Descriptive` Grohe 2017, *Descriptive Complexity, Canonisation, and Definable Graph…* (?) [1·A] — Lecture Notes in Logic 47; `NielsenChuang2010Quantum` Nielsen–Chuang 2010, *Quantum Computation and Quantum Information* (?) [1·A] — —; `TentZiegler2012Course` Tent–Ziegler 2012, *Model Theory* (?) [1·A] — Lecture Notes in Logic 40; `TroelstraSchwichtenberg2000Basic` Troelstra–Schwichtenberg 2000, *Basic Proof Theory* (?) [1·A] — Cambridge Tracts in Theoretical Computer Science 43; `KushilevitzNisan1997Communication` Kushilevitz–Nisan 1997, *Communication Complexity* (?) [1·B] — —; `RaoYehudayoff2020Communication` Rao–Yehudayoff 2020, *Communication Complexity and Applications* (?) [1·B] — —; `ZurGathenGerhard2013Modern` von zur Gathen–Gerhard 2013, *Modern Computer Algebra* (?) [1·B] — —
- **Elsevier** (6): `MacWilliamsSloane1977Theory` MacWilliams–Sloane 1977, *Theory of Error-Correcting Codes* (?) [2·A] — Mathematical Library 16; `Barendregt1984Lambda` Barendregt 1984, *Lambda Calculus* (?) [1·A] — Studies in Logic and the Foundations of Mathematics 103; `Jech1973Axiom` Jech 1973, *Axiom of Choice* (?) [1·A] — Studies in Logic and the Foundations of Mathematics 75 (Dover reprint 2008); `Kunen1980Set` Kunen 1980, *Set Theory* (?) [1·A] — Studies in Logic and the Foundations of Mathematics 102; `PerrinPin2004Infinite` Perrin–Pin 2004, *Infinite Words* (?) [1·A] — Pure and Applied Mathematics 141; `SorensenUrzyczyn2006Lectures` Sørensen–Urzyczyn 2006, *Curry–Howard Isomorphism* (?) [1·A] — Studies in Logic and the Foundations of Mathematics 149
- **American Mathematical Society** (2): `Baldwin2009Categoricity` Baldwin 2009, *Categoricity* (?) [1·A] — University Lecture Series 50; `KitaevShenVyalyi2002Classical` Kitaev–Shen–Vyalyi 2002, *Classical and Quantum Computation* (?) [1·A] — Graduate Studies in Mathematics 47
- **MIT Press** (2): `CormenEtAl2022Algorithms` Cormen et al. 2022, *Algorithms* (?) [2·A] — MIT Press; `Matiyasevich1993Hilbert` Matiyasevich 1993, *Hilbert's Tenth Problem* (?) [1·A] — MIT Press
- **Taylor & Francis** (2): `Shoenfield1967Mathematical` Shoenfield 1967, *Mathematical Logic* (?) [2·A] — Addison-Wesley (reprinted ASL/A K Peters 2001); `Gao2009Invariant` Gao 2009, *Invariant Descriptive Set Theory* (?) [1·A] — Pure and Applied Mathematics 293, CRC Press
- **Pearson (Addison-Wesley, Prentice Hall, Benjamin)** (2): `Knuth1997Art` Knuth 1997, *Art of Computer Programming, Vol. 2* (?) [1·B] — Addison-Wesley; `Papadimitriou1994Computational` Papadimitriou 1994, *Computational Complexity* (?) [1·B] — Addison-Wesley
- **Wiley** (1): `CoverThomas2006Elements` Cover–Thomas 2006, *Information Theory* (?) [1·A] — -Interscience
- **McGraw-Hill** (1): `Davis1958Computability` Davis 1958, *Computability and Unsolvability* (?) [1·A] — McGraw-Hill (enlarged Dover reprint 1982)
- **Macmillan Learning (W. H. Freeman)** (1): `GareyJohnson1979Computers` Garey–Johnson 1979, *Computers and Intractability* (?) [1·B] — W. H. Freeman
- **Matrix Editions** (1): `Hubbard2006Teichmuller` Hubbard 2006, *Teichmüller Theory and Applications to Geometry, Topology…* (?) [1·B] — Matrix Editions
- **IEEE** (1): `IEEE2015IEEE` Society 2015, *IEEE Standard for Interval Arithmetic (IEEE Std 1788-2015)* (?) [1·A] — IEEE
- **Dover** (1): `MosherTangora1968Cohomology` Mosher–Tangora 1968, *Cohomology Operations and Applications in Homotopy Theory* (?) [1·B] — Harper & Row (Dover reprint 2008)

## (d) Publisher not determined

- `ForsterEtAl2020Coq` Forster et al. 2020, *Coq library of undecidable problems* (?) [1·A] — Y. Forster, D. Larchey-Wendling, A. Dudenhefner, E. Heiter, D. Kirst, F. Kunze, G. Smolka, S. Spies, D. Wehr, M. Wuttke, *A Coq library of undecidable problems*, CoqPL 2020, 2020
- `Giroux2002Geometrie` Giroux 2002, *Géométrie de contact* (?) [1·A] — E. Giroux, *Géométrie de contact: de la dimension trois vers les dimensions supérieures*, Proceedings of the ICM Beijing 2002, Vol. II, 405–414, 2002
- `Ihara1991Braids` Ihara 1991, *Braids, Galois groups, and some arithmetic functions* (?) [1·A] — Y. Ihara, *Braids, Galois groups, and some arithmetic functions*, Proceedings of the ICM Kyoto 1990, Vol. I, 99–120, 1991
- `Saptharishi2021Survey` Saptharishi 2021, *Survey of lower bounds in arithmetic circuit complexity* (?) [1·A] — R. Saptharishi (with contributors), *A survey of lower bounds in arithmetic circuit complexity*, online survey (GitHub), continuously updated, 2021
- `Wormald1999Differential` Wormald 1999, *Differential equation method for random graph processes and…* (?) [1·A] — N. C. Wormald, *The differential equation method for random graph processes and greedy algorithms*, in Lectures on Approximation and Randomized Algorithms (M. Karoński, H. J. Prömel, eds.), PWN, Warsaw, 73–155, 1999
- `Lek1983Homotopy` van der Lek 1983, *Homotopy type of complex hyperplane complements* (?) [1·B] — H. van der Lek, *The homotopy type of complex hyperplane complements*, PhD thesis, Katholieke Universiteit Nijmegen, 1983
- `Levelt1961Hypergeometric` Levelt 1961, *Hypergeometric Functions* (?) [1·B] — A. H. M. Levelt, *Hypergeometric Functions*, doctoral thesis, University of Amsterdam, 1961
- `Selberg1992Old` Selberg 1992, *Old and new conjectures and results about a class of…* (?) [1·B] — A. Selberg, *Old and new conjectures and results about a class of Dirichlet series*, Proceedings of the Amalfi Conference on Analytic Number Theory (1989), Univ. Salerno, 367-385, 1992
- `Bokstedt1985Topological` Bökstedt 1985, *Topological Hochschild homology* (?) [1·C] — M. Bökstedt, *Topological Hochschild homology*, preprint, Universität Bielefeld, 1985
- `LutkebohmertNDWork` Lütkebohmert n.d., *work cited as [Lüt95, Theorem 5.3] (curve compactification…* (?) [1·C] — W. Lütkebohmert, *work cited as [Lüt95, Theorem 5.3] (curve compactification for biduality)*, to be identified from the ECD/Huber bibliographies, 

## (e) Journal → publisher table used

| Journal | Publisher (imprint; rule by year cited) |
|---|---|
| Invent. Math. | Springer Nature (Springer) |
| Math. Ann. | Springer Nature (Springer) |
| Math. Z. | Springer Nature (Springer) |
| GAFA | Springer Nature (Birkhäuser/Springer) |
| Comm. Math. Phys. | Springer Nature (Springer) |
| Publ. Math. IHÉS | Springer Nature (Springer (for IHÉS)) |
| Israel J. Math. | Springer Nature (Springer (Magnes Press)) |
| J. Anal. Math. | Springer Nature (Springer (Magnes Press)) |
| Combinatorica | Springer Nature (Springer) |
| Discrete Comput. Geom. | Springer Nature (Springer) |
| Z. Wahrsch. Verw. Gebiete | Springer Nature (Springer) |
| Probab. Theory Related Fields | Springer Nature (Springer) |
| Arch. Ration. Mech. Anal. | Springer Nature (Springer) |
| J. Stat. Phys. | Springer Nature (Springer) |
| Lett. Math. Phys. | Springer Nature (Springer) |
| Calc. Var. PDE | Springer Nature (Springer) |
| Comput. Complexity | Springer Nature (Birkhäuser/Springer) |
| Acta Inform. | Springer Nature (Springer) |
| Int. J. Game Theory | Springer Nature (Springer) |
| Period. Math. Hungar. | Springer Nature (Springer (Akadémiai Kiadó)) |
| K-Theory | Springer Nature (Kluwer) |
| J. Soviet Math. | Springer Nature (Springer (translation)) |
| Funct. Anal. Appl. | Springer Nature (Springer (translation of Funkts. Anal.)) |
| Selecta Math. | Springer Nature (Birkhäuser/Springer) |
| Manuscripta Math. | Springer Nature (Springer) |
| Math. Program. | Springer Nature (Springer) |
| Algorithmica | Springer Nature (Springer) |
| Geom. Dedicata | Springer Nature (Springer) |
| Transform. Groups | Springer Nature (Birkhäuser/Springer) |
| Ann. Henri Poincaré | Springer Nature (Birkhäuser/Springer) |
| Acta Sci. Math. (Szeged) | Springer Nature (Springer (Bolyai Institute)) (?) |
| Comment. Math. Helv. | EMS Press from 2004; Birkhäuser (Springer Nature) before; 1929–2003 free on e-periodica |
| Acta Math. | International Press from 2018; Springer Nature (Institut Mittag-Leffler) 2006–2017 and, for the backfile, before (?) |
| Ark. Mat. | International Press from 2017 (?); Springer Nature (Institut Mittag-Leffler) before (?) |
| Compositio Math. | Cambridge University Press (LMS / Foundation Compositio) from 2004; Kluwer (Springer Nature) 1980s–2003; Noordhoff before (?); 1935–1996 free on Numdam |
| Topology | Elsevier (Pergamon) |
| Topology Appl. | Elsevier (North-Holland) |
| Adv. Math. | Elsevier (Academic Press) |
| J. Algebra | Elsevier (Academic Press) |
| J. Number Theory | Elsevier (Academic Press) |
| J. Combin. Theory | Elsevier (Academic Press) |
| J. Funct. Anal. | Elsevier (Academic Press) |
| J. Pure Appl. Algebra | Elsevier (North-Holland) |
| Discrete Math. | Elsevier (North-Holland) |
| Linear Algebra Appl. | Elsevier (North-Holland) |
| Theoret. Comput. Sci. | Elsevier |
| J. Comput. System Sci. | Elsevier (Academic Press) |
| Ann. Pure Appl. Logic | Elsevier (North-Holland) |
| Indag. Math. | Elsevier (North-Holland (KNAW)) |
| European J. Combin. | Elsevier (Academic Press) |
| J. Math. Anal. Appl. | Elsevier (Academic Press) |
| Nonlinear Anal. | Elsevier (Pergamon) |
| Phys. Lett. B | Elsevier (North-Holland) |
| J. Symbolic Comput. | Elsevier (Academic Press) |
| Inform. Comput. | Elsevier (Academic Press) |
| Stochastic Process. Appl. | Elsevier (North-Holland) |
| Ann. Inst. H. Poincaré | Elsevier (Gauthier-Villars / Elsevier) (?) |
| J. Math. Pures Appl. | Elsevier (Gauthier-Villars / Elsevier) |
| Bull. Sci. Math. | Elsevier (Gauthier-Villars / Elsevier) |
| C. R. Acad. Sci. Paris | Gauthier-Villars (Elsevier) before 1997, free on Gallica; Elsevier 1997–2019; Académie des sciences / Centre Mersenne from 2020 |
| Ann. Sci. ENS | Gauthier-Villars before 1997 (?), Elsevier 1997–2007, SMF from 2008; older volumes free on Numdam |
| Comm. Pure Appl. Math. | Wiley |
| J. Graph Theory | Wiley |
| Random Structures Algorithms | Wiley |
| Math. Nachr. | Wiley |
| LMS journals | Proc./J./Bull. LMS: Wiley from 2017, Oxford University Press before (pre-1960 publisher varies (?)); the whole backfile is on Wiley Online |
| Mathematika | Wiley (LMS) from 2017; Cambridge University Press / UCL before (?) |
| LMS J. Comput. Math. | Cambridge University Press (Cambridge University Press (LMS)) (?) |
| Combin. Probab. Comput. | Cambridge University Press |
| Math. Proc. Cambridge Philos. Soc. | Cambridge University Press |
| Forum Math. Pi/Sigma | Cambridge University Press |
| J. Inst. Math. Jussieu | Cambridge University Press |
| Canad. J. Math. / Canad. Math. Bull. | Cambridge University Press (Cambridge University Press (CMS)) (?) |
| J. Aust. Math. Soc. | Cambridge University Press |
| Glasg. Math. J. | Cambridge University Press |
| Nagoya Math. J. | Cambridge University Press (Cambridge University Press (Nagoya University)) (?) |
| J. Symbolic Logic | Cambridge University Press (Cambridge University Press (ASL)) (?) |
| J. Appl. Probab. | Cambridge University Press (Cambridge University Press (Applied Probability Trust)) (?) |
| Ergodic Theory Dynam. Systems | Cambridge University Press |
| Quart. J. Pure Appl. Math. (historical) | Quart. J. Pure Appl. Math. (historical, print only) |
| Q. J. Math. | Oxford University Press (Quarterly Journal of Mathematics, Oxford Series, from 1930); its predecessor, Quart. J. Pure Appl. Math., is listed separately |
| IMRN | Oxford University Press |
| Ann. of Math. | Princeton University Press / Annals of Mathematics (Annals of Mathematics (Princeton)) |
| J. Amer. Math. Soc. | American Mathematical Society |
| Trans. Amer. Math. Soc. | American Mathematical Society |
| Proc. Amer. Math. Soc. | American Mathematical Society |
| Bull. Amer. Math. Soc. | American Mathematical Society |
| Math. Comp. | American Mathematical Society |
| Represent. Theory | American Mathematical Society |
| J. Algebraic Geom. | American Mathematical Society (University Press Inc. (AMS)) (?) |
| Soviet Math. Dokl. | American Mathematical Society (AMS (translation)) |
| Leningrad / St. Petersburg Math. J. | American Mathematical Society (AMS (translation)) |
| Proc. St. Petersburg Math. Soc. | American Mathematical Society (AMS Translations) |
| Amer. Math. Monthly | Taylor & Francis (Taylor & Francis (MAA)) (?) |
| Amer. J. Math. | Johns Hopkins University Press |
| Duke Math. J. | Duke University Press |
| Illinois J. Math. | Duke University Press (Duke University Press (University of Illinois)) (?) |
| J. Math. Kyoto Univ. / Kyoto J. Math. | Duke University Press (Duke University Press (Kyoto University)) (?) |
| Michigan Math. J. | University of Michigan |
| Indiana Univ. Math. J. | Indiana University |
| J. Differential Geom. | International Press (International Press (Lehigh University)) |
| Math. Res. Lett. | International Press |
| Camb. J. Math. | International Press |
| Pure Appl. Math. Q. | International Press |
| Comm. Anal. Geom. | International Press |
| Pacific J. Math. | MSP |
| Algebra Number Theory | MSP |
| Geom. Topol. | MSP |
| Algebr. Geom. Topol. | MSP |
| Anal. PDE | MSP |
| Ann. K-Theory | MSP |
| J. Eur. Math. Soc. | EMS Press |
| Doc. Math. | EMS Press (EMS Press (open access; self-published before 2022)) (?) |
| L'Enseign. Math. | EMS Press from 2014; Université de Genève before (?) |
| Publ. RIMS | EMS Press (EMS Press (RIMS, Kyoto)) (?) |
| Rev. Mat. Iberoam. | EMS Press |
| Groups Geom. Dyn. | EMS Press |
| Astérisque | Société Mathématique de France |
| Bull. Soc. Math. France | Société Mathématique de France |
| Mém. Soc. Math. France | Société Mathématique de France |
| J. reine angew. Math. (Crelle) | De Gruyter Brill (De Gruyter) |
| Forum Math. | De Gruyter Brill (De Gruyter) |
| Rev. Math. Phys. | World Scientific |
| Int. J. (World Scientific) | World Scientific |
| J. Knot Theory Ramifications | World Scientific |
| SIAM journals | SIAM |
| SODA | SIAM (SIAM (with ACM)) |
| J. ACM | ACM |
| STOC | ACM |
| ACM proceedings and journals | ACM |
| LIPIcs | Schloss Dagstuhl (LIPIcs) |
| CCC | Schloss Dagstuhl (LIPIcs) from 2016; IEEE before |
| IEEE proceedings and journals | IEEE |
| Arch. Math. | Springer Nature (Birkhäuser/Springer) |
| Expo. Math. | Elsevier |
| J. Topol. | London Mathematical Society (Wiley (LMS)) |
| Experiment. Math. | Taylor & Francis (Taylor & Francis (A K Peters)) |
| Ann. Physics | Elsevier (Academic Press) |
| Z. Phys. | Springer Nature (Springer) |
| Math. Notes (transl. of Mat. Zametki) | Springer Nature (Springer (translation)) |
| J. Differential Equations | Elsevier (Academic Press) |
| Comm. Algebra | Taylor & Francis |
| Comm. PDE | Taylor & Francis |
| Computing | Springer Nature (Springer) |
| Algebra Universalis | Springer Nature (Birkhäuser/Springer) |
| Cahiers Topol. Géom. Différ. | Centre Mersenne (open access) (Numdam) (?) |
| Homology Homotopy Appl. | International Press |
| Theory Appl. Categ. | Open access (Mount Allison University) |
| Theory Comput. | Open access (Theory of Computing) |
| Discrete Anal. | Open access (Discrete Analysis) |
| Acta Numer. | Cambridge University Press |
| Found. Comput. Math. | Springer Nature (Springer) |
| Games Econom. Behav. | Elsevier (Academic Press) |
| Int. J. Quantum Chem. | Wiley |
| IBM J. Res. Develop. | IEEE (IBM (IEEE Xplore)) (?) |
| Abh. Math. Sem. Univ. Hamburg | Springer Nature (Springer) |
| Res. Math. Sci. | Springer Nature (Springer) |
| J. Théor. Nombres Bordeaux | Centre Mersenne (open access) (Société Arithmétique de Bordeaux) |
| J. Math. Sci. Univ. Tokyo | University of Tokyo |
| Boll. UMI | Springer Nature (Springer (Unione Matematica Italiana; older volumes UMI)) (?) |
| Nachr. Akad. Wiss. Göttingen | De Gruyter Brill (Vandenhoeck & Ruprecht) (?) |
| Ann. Fac. Sci. Toulouse | Centre Mersenne (open access) (Université Paul Sabatier) |
| Living Rev. Relativ. | Springer Nature (Springer (open access)) |
| J. Éc. polytech. Math. | Centre Mersenne (open access) (École polytechnique) |
| J. Algebraic Combin. | Springer Nature (Springer) |
| Int. J. Pure Appl. Math. | Academic Publications (Sofia) (?) |
| Bolyai Soc. Math. Stud. | Springer Nature (Springer (János Bolyai Math. Society)) |
| J. Indian Math. Soc. | Indian Mathematical Society |
| Proc. R. Soc. / Phil. Trans. | Royal Society |
| J. Math. Soc. Japan | Mathematical Society of Japan |
| Tôhoku Math. J. | Tohoku University |
| Kodai Math. J. | Tokyo Institute of Technology |
| Proc. Japan Acad. | Japan Academy |
| Amer. Math. Soc. Transl. | American Mathematical Society (AMS (translation)) |
| RAS journals (Izv., Mat. Sb., Uspekhi, Dokl.) | Russian Academy of Sciences journals (Russian Academy of Sciences (translations: AMS / IOP / LMS-Turpion)) |
| Moscow Math. J. | Independent University of Moscow (Independent University of Moscow (distributed by AMS)) (?) |
| IMS journals | Institute of Mathematical Statistics |
| Proc. Natl. Acad. Sci. USA | National Academy of Sciences |
| Math. Scand. | Mathematica Scandinavica |
| IMPAN journals | Polish Academy of Sciences (IMPAN) |
| J. Operator Theory | Theta Foundation (Bucharest) |
| J. Ramanujan Math. Soc. | Ramanujan Mathematical Society |
| Electron. J. Combin. | Electronic Journal of Combinatorics (open access) |
| Inverse Problems | IOP Publishing |
| APS journals | American Physical Society |
| J. Math. Phys. | AIP Publishing |
| Foundations and Trends | now publishers |
| Philips Res. Rep. | Philips Research (print only) |
| Confluentes Math. | Centre Mersenne (open access) (?) |
| Ann. Inst. Fourier | Centre Mersenne (open access) (Ann. Inst. Fourier) |
| East J. Approx. | DARBA (Sofia) (?) |
