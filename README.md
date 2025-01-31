# puppet-pdk-training

PDK new <>
Benodigdheden:
-	Visual studio code
-	 PDK 3.4.0 geïnstalleerd

1.	Maak een folder aan op je systeem met de naam PDKtraining
2.	Open de folder in  visual studio code.
3.	Open een powerrshell terminal
4.	Run het volgende commando:
    - pdk new module kpn-pdk_training --skip-interview --template-url git@github.tooling.kpn.org:team-puppet-modulebouw/pdk_templates
5.	bekijk de inhoud van de nieuwe pdk_training folder je hebt nu een lege module gemaakt. 
6.	Ga in de powershell terminal naar de folder en run het volgende commando:
    -	pdk new class pdk_training
7.	Bekijk de 2 files die worden aangemaakt.

8.	Gefeliciteerd je hebt een volledig nieuwe module gemaakt waar je eigen code in kan zetten.
 

# PDK convert

1.	Ga in Visual studio code in de terminal weer terug naar je PDKtraining hoofd folder.

2.	Doe een git clone van de  puppet-kpn-pdk_training module:
git clone git@github.tooling.kpn.org:tooling-automation/puppet-kpn-pdk_training.git

3.	Ga in de terminal naar puppet-kpn-pdk_training folder.

4.	Maak een nieuwe branch aan met je eigen naam.

5.	Zorg dat je in je branch zit binnen Visual studio code en voer het volgende commando uit:
pdk convert --template-url git@github.tooling.kpn.org:team-puppet-modulebouw/pdk_templates

6.	Bij de vraag: 
Do you want to continue and make these changes to your module? (Y/n)  
typ:  Y

7.	Commit en push al je changes naar je branch die je net hebt aangemaakt.

8.	ga naar Jenkins.
https://jenkins.tooling.kpn.org:8443/job/Github%20Organization/job/tooling-automation/job/puppet-kpn-pdk_training/ 

9.	klik op jouw branch naam. (KAN EVEN DUREN VOORDAT DIE ZICHTBAAR IS)

10.	Aan de linker kant zie je de Build History staan als goed is komt hier een #1 te staan klik hierop en klik daarna op Open Blue Ocean.
(klik op het hoogste getal wat er staat dit kan ook #2 of #3  enz zijn)

11.	Controleer of alle testen goed gaan?

12.	Zoals je ziet gaat de PDK smoke test al fout waardoor de rest van de tests ook niet meer zullen doorgaan.

13.	Ga terug naar je Visual studio code en laten we de errors gaan fixen! 😊

14.	Zorg dat je in je puppet-kpn-pdk_training folder zit en run het volgende commando:
    pdk validate --puppet-version=7 
15.	Je ziet de onderstaande 3 foutmeldingen staan probeer deze te fixen!
    De foutmelding geeft al aan in welke bestanden de fouten zitten.  Succes!! 😊

16.	Na iedere keer dat je wat gefixt hebt run je het commando: pdk validate --puppet-version=7 net zolang tot dat je alle fouten hebt opgelost.

17.	Als je alles hebt opgelost commit en push al je wijzigingen naar je branch en ga dan naar Jenkins en controleer of de PDK smoke tests nu wel groen worden?

18.	Nu ben je weer een stapje verder maar nu gaat de PDK Rspec fout.

19.	Ga terug naar je terminal in Visual studio code en run het volgende commando:
    pdk test unit --puppet-version=7 --verbose

20.	Je ziet nu een aantal failures en je hebt ook een paar Untouched recources ga nu naar 
    puppet-kpn-pdk_training\spec\classes\00_init_spec.rb bestand en probeer alle failures en Untouched recources te fixen. Succes!! 😊

21.	Na iedere keer dat je wat gefixt hebt run je het commando: 
    pdk test unit --puppet-version=7 --verbose  net zolang tot dat je alle fouten hebt opgelost.

22.	Je ziet dat de testen in de terminal alleen maar voor windows-2016-x86_64 en voor redhat-8-x86_64 zijn zorg ervoor dat ook de testen worden gedaan op Windows 2019, 2022 en op RedHat 9.  Succes!! 😊

23.	Als je alles hebt opgelost commit en push al je wijzigingen naar je branch en ga dan naar Jenkins en controleer of de PDK Rspec tests nu wel groen worden?

24.	Je ziet nu dat alle Beakers fout gaan, beakers is een apart onderdeel en is een hoofdstuk opzich, maar je wilt natuurlijk wel dat alles groen is in Jenkins als je nu in je directory naar de Jenkinsfile gaat zie je hier 
    platforms: staan haal hier alle platforms weg en doe dan een commit en push dan zul je zien dat alles netjes groen is zonder de beakers.

25.	Done!!

