Profile: ISiKPatient
Parent: Patient
Id: ISiKPatient
Description: "Dieses Profil die Nutzung von administrativen Patientendaten in ISiK Szenarien."
* ^version = "1.0"
* obeys isik-pat-1
* . ^constraint[5].source = "http://gematik.de/fhir/ISiK/StructureDefinition/ISiKPatient"
* id 1.. MS
* identifier MS
  * ^slicing.discriminator.type = #pattern
  * ^slicing.discriminator.path = "$this"
  * ^slicing.rules = #open
* identifier contains
    Versichertennummer-GKV 0..1 MS and
    Patientennummer 1..* MS and
    Versichertennummer_PKV 0..1
* identifier[Versichertennummer-GKV] only IdentifierKvid10
  * ^patternIdentifier.type = $identifier-type-de-basis#GKV
  * type 1.. MS
  * system MS
  * value MS
* identifier[Patientennummer] only IdentifierPid
  * ^patternIdentifier.type = $v2-0203#MR
  * type MS
  * system MS
  * value MS
* identifier[Versichertennummer_PKV] only IdentifierPkv
  * ^patternIdentifier.type = $identifier-type-de-basis#PKV
  * ^mustSupport = false
  * use MS
  * type 1.. MS
  * value MS
  * assigner MS
    * identifier.system MS
    * identifier.value MS
    * display MS
* active MS
* name MS
  * ^slicing.discriminator.type = #pattern
  * ^slicing.discriminator.path = "$this"
  * ^slicing.rules = #open
  * ^comment = "In order to maintain the differntiations of name parts as given in the VSDM dataset or qualify prefixes as academic titles, vendors can opt to support the extensions specified in the German HumanName Base Profile https://simplifier.net/basisprofil-de-r4/humannamedebasis\r\nThis is however not required within the scope of this specification."
* name contains
    Name 1..1 MS and
    Geburtsname 0..1 MS
* name[Name] only HumannameDeBasis
  * ^patternHumanName.use = #official
  * use 1.. MS
  * family 1.. MS
    * extension[namenszusatz] 0..1 MS
    * extension[nachname] 0..1 MS
    * extension[vorsatzwort] 0..1 MS
  * given 1.. MS
  * prefix MS
    * extension[prefix-qualifier] 0..1 MS
    * extension[prefix-qualifier].value[x] = #AC (exactly)
* name[Geburtsname] only HumannameDeBasis
  * ^patternHumanName.use = #maiden
  * use 1.. MS
  * family 1.. MS
    * extension[namenszusatz] 0..1 MS
    * extension[nachname] 0..1 MS
    * extension[vorsatzwort] 0..1 MS
  * given ..0
  * prefix ..0
* telecom.system 1..
* telecom.value 1..
* gender 1.. MS
  * extension contains GenderOtherDE named Geschlecht-Administrativ 0..1 MS
* birthDate 1.. MS
  * extension contains $data-absent-reason named Data-Absent-Reason 0..1 MS
  * extension[Data-Absent-Reason].value[x] = #unknown (exactly)
  * extension[Data-Absent-Reason].value[x] MS
* address MS
  * ^slicing.discriminator.type = #pattern
  * ^slicing.discriminator.path = "$this"
  * ^slicing.rules = #open
  * ^comment = "In order to differentiate between post box addresses and physical addresses, street names and house numbers, and to add city district names, vendors can opt to support the extensions as suggested in the German Address Base Profile http://fhir.de/StructureDefinition/address-de-basis.\r\nSuch differentiations are however not required within the scope of this specification."
* address contains
    Strassenanschrift 0..* MS and
    Postfach 0..* MS
  * type 1.. MS
  * city 1.. MS
  * postalCode 1.. MS
* address[Strassenanschrift] only AddressDeBasis
  * ^patternAddress.type = #both
  * extension contains Stadtteil 0..1
  * extension[Stadtteil] ^mustSupport = false
  * line 1.. MS
    * extension contains
        Strasse 0..1 MS and
        Hausnummer 0..1 MS and
        Adresszusatz 0..1 MS and
        Postfach 0..0
  * country 1.. MS
    * obeys pat-cnt-2or3-char
    * ^constraint[1].source = "http://gematik.de/fhir/ISiK/StructureDefinition/ISiKPatient"
* address[Postfach] only AddressDeBasis
  * ^patternAddress.type = #postal
  * extension contains Stadtteil 0..1
  * extension[Stadtteil] ^mustSupport = false
  * line 1.. MS
    * extension contains
        Strasse 0..0 and
        Hausnummer 0..0 and
        Adresszusatz 0..0 and
        Postfach 0..1 MS
  * country 1.. MS
    * obeys pat-cnt-2or3-char
    * ^constraint[1].source = "http://gematik.de/fhir/ISiK/StructureDefinition/ISiKPatient"

Instance: patient
InstanceOf: ISiKPatient
Usage: #example
* identifier[0].type = $identifier-type-de-basis#GKV
* identifier[=].system = "http://fhir.de/sid/gkv/kvid-10"
* identifier[=].value = "A123456789"
* identifier[+].type = $v2-0203#MR
* identifier[=].system = "https://fhir.krankenhaus.example/NamingSystem/PID"
* identifier[=].value = "TestPID"
* identifier[+].use = #secondary
* identifier[=].type = $identifier-type-de-basis#PKV
* identifier[=].value = "1234567890"
* identifier[=].assigner.display = "Test PKV AG"
* active = true
* name[0].use = #official
* name[=].family = "Fürstin Von Musterfrau"
  * extension[0].url = "http://fhir.de/StructureDefinition/humanname-namenszusatz"
  * extension[=].valueString = "Graf"
  * extension[+].url = "http://hl7.org/fhir/StructureDefinition/humanname-own-name"
  * extension[=].valueString = "Musterfrau"
  * extension[+].url = "http://hl7.org/fhir/StructureDefinition/humanname-own-prefix"
  * extension[=].valueString = "Von"
* name[=].given = "Erika"
* name[=].prefix = "Dr."
  * extension.url = "http://hl7.org/fhir/StructureDefinition/iso21090-EN-qualifier"
  * extension.valueCode = #AC
* name[+].use = #maiden
* name[=].family = "Gabler"
  * extension.url = "http://hl7.org/fhir/StructureDefinition/humanname-own-name"
  * extension.valueString = "Gabler"
* gender = #female
* birthDate = "1964-08-12"
* address[0].type = #both
* address[=].line[0] = "Musterweg 2"
* address[=].line[+] = "3. Etage"
* address[=].line[0].extension[0].url = "http://hl7.org/fhir/StructureDefinition/iso21090-ADXP-streetName"
* address[=].line[=].extension[=].valueString = "Musterweg"
* address[=].line[=].extension[+].url = "http://hl7.org/fhir/StructureDefinition/iso21090-ADXP-houseNumber"
* address[=].line[=].extension[=].valueString = "2"
* address[=].line[+].extension.url = "http://hl7.org/fhir/StructureDefinition/iso21090-ADXP-additionalLocator"
* address[=].line[=].extension.valueString = "3. Etage"
* address[=].city = "Musterhausen"
* address[=].postalCode = "98764"
* address[=].country = "DE"
* address[+].type = #postal
* address[=].line = "Postfach 8 15"
  * extension.url = "http://hl7.org/fhir/StructureDefinition/iso21090-ADXP-postBox"
  * extension.valueString = "Postfach 8 15"
* address[=].city = "Musterhausen"
* address[=].postalCode = "98764"
* address[=].country = "DE"

Invariant: isik-pat-1
Description: "Falls die Geschlechtsangabe 'other' gewählt wird, muss die amtliche Differenzierung per Extension angegeben werden"
Severity: #error
Expression: "gender.exists() and gender='other' implies gender.extension('http://fhir.de/StructureDefinition/gender-amtlich-de').exists()"