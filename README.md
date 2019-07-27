# Petnica2019

nacrtaj.m: u�itava niz zrakova (intenzitet, polozaj, kvector) iz input.txt i pokre�e zrak() dok god se svi zraci ne izsimuliraju

zrak.m: za jedan zrak, simulira i plotuje njegovu putanju, i vra�a dva nova zraka kada se zrak prelomi/odbije

propagate.m: uzima parametre zraka, simulira jedan korak zraka runge-kutom 4, i vra�a novu trojku

setup.m: samo iscrtava krugove kao granice na kojima se menja indeks prelamanja

permittivity_old.m: stara funkcija koja vra�a dielektri�nu i dijamagnetnu permitivnost (ako se tako ka�e uop�te, uvek zaboravim), 99% nam vi�e ne�e trebati

permittivity.m: ovako se ranije zvala funkcija, pa ova samo preusmerava na permittivity_sigmoid.m jer me je mrzelo da menjam svaki poziv u kodu

permittivity_sigmoid.m: funkcija za permitivnost koja na granicama izme�u oblasti vra�a sigmoidnu funkciju, da bi se lep�e izintegralilo

test_numerika: samo plotuje kako zavisi kosinus refraktovanog od y pozicije sa koje se pu�ta zrak, i kakvu zavisnost predvi�a Snelov zakon

Optimizacija.m: ne znam �ta radi, trebalo bi da bude interfejs za kori��enje fmincon()

TO-DO:
1)Dinami�ki step (bitno je zbog vremena izvr�avanja simulacije)
2)Iskucati fju koja poziva zrak() 20tak puta, i sabira intenzitet koji izlazi (ra�una efikasnost)
3)Pustiti simulaciju :)	