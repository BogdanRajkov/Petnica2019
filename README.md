# Petnica2019

nacrtaj.m: uèitava niz zrakova (intenzitet, polozaj, kvector) iz input.txt i pokreæe zrak() dok god se svi zraci ne izsimuliraju

zrak.m: za jedan zrak, simulira i plotuje njegovu putanju, i vraæa dva nova zraka kada se zrak prelomi/odbije

propagate.m: uzima parametre zraka, simulira jedan korak zraka runge-kutom 4, i vraæa novu trojku

setup.m: samo iscrtava krugove kao granice na kojima se menja indeks prelamanja

permittivity_old.m: stara funkcija koja vraæa dielektriènu i dijamagnetnu permitivnost (ako se tako kaže uopšte, uvek zaboravim), 99% nam više neæe trebati

permittivity.m: ovako se ranije zvala funkcija, pa ova samo preusmerava na permittivity_sigmoid.m jer me je mrzelo da menjam svaki poziv u kodu

permittivity_sigmoid.m: funkcija za permitivnost koja na granicama izmeðu oblasti vraæa sigmoidnu funkciju, da bi se lepše izintegralilo

test_numerika: samo plotuje kako zavisi kosinus refraktovanog od y pozicije sa koje se pušta zrak, i kakvu zavisnost predviða Snelov zakon

Optimizacija.m: ne znam šta radi, trebalo bi da bude interfejs za korišæenje fmincon()

TO-DO:
1)Dinamièki step (bitno je zbog vremena izvršavanja simulacije)
2)Iskucati fju koja poziva zrak() 20tak puta, i sabira intenzitet koji izlazi (raèuna efikasnost)
3)Pustiti simulaciju :)	