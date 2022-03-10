# REST-API

## Read-Interaktionen
Instanzen von Datenobjekten, die die REST-Interaktion "READ" fordern MÜSSEN per HTTP GET auf ```[BASE_URL]/[resourceType]/[ID]``` abgerufen werden können. 
Siehe: https://www.hl7.org/fhir/http.html#read 

## Search-Interaktionen
Die Suche MUSS sowohl mittels HTTP GET als auch HTTP POST (vgl. [FHIR RESTful Search - Introduction](https://www.hl7.org/fhir/search.html#Introduction)) unterstützt werden. Die URL-Parameter komplexer Suchanfragen können personenbezogene Merkmale enthalten, daher ist im Echtbetrieb die Suche mittels HTTP POST in Verbindung mit TLS-Verschlüsselung vorzuziehen. 

## Create-Interaktionen
Das Erstellen einer Ressource KANN per HTTP POST (vgl. [FHIR RESTful API - create](https://www.hl7.org/fhir/http.html#create)) unterstützt werden. Einzelne Datenobjekte (spezifiziert im vorliegenden Basismodul oder in einem ISiK Erweiterungsmodul) können diese Interaktion als verpflichtend kennzeichnen.

Eine Ressource welche NICHT durch das bestäigungsrelevante System angelegt wird MUSS in ```Resource.meta.tag``` eine Angabe enthalten, dass diese Ressource durch ein Fremdsystem erzeugt wurden ist. Dieser Tag MUSS durch den Server hinzugefügt werden, sollte der Client diese Angabe nicht mitübermitteln.

Eine weitere Differenzierung der Herkunft kann mittels ```Resource.meta.security``` kodiert werden. Hierzu KÖNNEN Codes aus dem ValueSet [SecurityIntegrityObservationValue](http://terminology.hl7.org/ValueSet/v3-SecurityIntegrityObservationValue) verwendet werden.

Sollte die erezugte Ressource dauerhaft übernommen werden in das bestäigungsrelevante System, MUSS der entsprechende Tag in ```Patient.meta.tag``` entfernt werden. Im diesem Falle MUSS die id der Ressource stabil bleiben und darf nicht geändert werden.

Per Create-Interaktion erzeugte Ressourcen MÜSSEN im Falle einer erfolgreichen Übermittelung direkt über die READ- und SEARCH-Interaktionen zur Verfügung gestellt werden.

Ressourcen welche nicht konfom zu einem entsprechenden ISiK-Profil sind MÜSSEN abgelehnt werden durch das bestätigungsrelevante System. Es MUSS ein HTTP 400 Status Code zurückgegeben werden. Zudem MUSS eine OperationOutcome-Ressource mitübermittelt werden als Antwort. Diese enthält einer Auflistung aller Fehler in der übermittelten Ressoure in kodierter Form. 


## Sicherheitsaspekte
Alle REST-Interaktionen müssen sowohl mittels HTTP als auch HTTPS (TLS-Verschlüsselung) unterstützt werden. Vorgaben zur TLS-Verschlüsselung sind dem nachfolgenden Link für die FHIR Security Check List zu entnehmen.
Im Echtbetrieb MUSS die Kommunikation ausschließlich per HTTPS erfolgen.
Weiterhin sind geeignete Maßnahmen zur Risiko-Minimierung (z.B. Benutzerautorisierung / -authentifikation) zu treffen, siehe http://build.fhir.org/security.html#6.1.0. 
Diese sind in Stufe 1 des ISiK Basismoduls jedoch nicht bestätigungsrelevant.