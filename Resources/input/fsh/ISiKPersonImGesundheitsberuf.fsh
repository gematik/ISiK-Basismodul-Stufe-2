Profile: ISiKPersonImGesundheitsberuf
Parent: Practitioner
Id: ISiKPersonImGesundheitsberuf
Description: "Dieses Profil ermöglicht die Nutzung von in Gesundheitsberufen tätigen Personen in ISiK Szenarien."
* ^status = #active
* obeys prac-de-1
* . ^constraint[5].source = "http://gematik.de/fhir/ISiK/StructureDefinition/Practitioner"
* id MS
* identifier 1.. MS
  * ^slicing.discriminator.type = #pattern
  * ^slicing.discriminator.path = "$this"
  * ^slicing.rules = #open
* identifier contains
    Arztnummer 0..* MS and
    EFN 0..1 MS
* identifier[Arztnummer] only IdentifierLanr
  * ^patternIdentifier.type = $v2-0203#LANR
  * type 1..
* identifier[EFN] only IdentifierEfn
  * ^patternIdentifier.type = $v2-0203#DN
  * type 1..
* name MS
  * ^slicing.discriminator.type = #pattern
  * ^slicing.discriminator.path = "$this"
  * ^slicing.rules = #open
* name contains
    Name 1..1 MS and
    Geburtsname 0..1
* name[Name] only HumannameDeBasis
  * ^patternHumanName.use = #official
  * use 1.. MS
  * use = #official (exactly)
  * family 1.. MS
  * given 1.. MS
  * prefix MS
* name[Geburtsname] only HumannameDeBasis
  * ^patternHumanName.use = #maiden
  * use 1.. MS
  * use = #maiden (exactly)
  * family 1..
  * given ..0
  * prefix ..0
* telecom.system 1..
* telecom.value 1..
* address ..*
  * ^slicing.discriminator.type = #pattern
  * ^slicing.discriminator.path = "$this"
  * ^slicing.rules = #open
* address contains
    Strassenanschrift 0..* and
    Postfach 0..1
* address[Strassenanschrift] only AddressDeBasis
  * ^patternAddress.type = #both
  * extension ^slicing.discriminator.type = #value
    * ^slicing.discriminator.path = "url"
    * ^slicing.rules = #open
  * extension contains Stadtteil 0..1 MS
  * type 1..
  * type = #both (exactly)
  * line 1..
    * extension ^slicing.discriminator.type = #value
      * ^slicing.discriminator.path = "url"
      * ^slicing.rules = #open
    * extension contains
        Strasse 0..1 MS and
        Hausnummer 0..1 MS and
        Adresszusatz 0..1 MS and
        Postfach 0..0
  * city 1..
  * postalCode 1..
  * country 1..
* address[Postfach] only AddressDeBasis
  * ^patternAddress.type = #postal
  * extension ^slicing.discriminator.type = #value
    * ^slicing.discriminator.path = "url"
    * ^slicing.rules = #open
  * extension contains Stadtteil 0..1 MS
  * type 1..
  * type = #postal (exactly)
  * line 1..
    * extension ^slicing.discriminator.type = #value
      * ^slicing.discriminator.path = "url"
      * ^slicing.rules = #open
    * extension contains
        Strasse 0..0 and
        Hausnummer 0..0 and
        Adresszusatz 0..0 and
        Postfach 0..1 MS
  * city 1..
  * postalCode 1..
  * country 1..
* gender MS
  * extension ^slicing.discriminator.type = #value
    * ^slicing.discriminator.path = "url"
    * ^slicing.rules = #open
  * extension contains GenderOtherDE named Geschlecht-Administrativ 0..1 MS
  * extension[Geschlecht-Administrativ].value[x] MS
* birthDate.extension ^slicing.discriminator.type = #value
  * ^slicing.discriminator.path = "url"
  * ^slicing.rules = #open
* birthDate.extension contains $data-absent-reason named Data-Absent-Reason 0..1 MS
* qualification.code.coding 1..
* qualification.code.coding from $KBV_VS_Base_Practitioner_Speciality (preferred)

Instance: practitioner
InstanceOf: ISiKPersonImGesundheitsberuf
Usage: #example
* meta.source = "http://krankenhaus.de"
* identifier[0].type = $v2-0203#LANR
* identifier[=].system = "https://fhir.kbv.de/NamingSystem/KBV_NS_Base_ANR"
* identifier[=].value = "123456789"
* identifier[+].type = $v2-0203#DN
* identifier[=].system = "http://fhir.de/sid/bundesaerztekammer/efn"
* identifier[=].value = "123456789123456"
* active = true
* name[0].use = #official
* name[=].text = "Walter Arzt"
* name[=].family = "Arzt"
  * extension.url = "http://hl7.org/fhir/StructureDefinition/humanname-own-name"
  * extension.valueString = "Arzt"
* name[=].given = "Walter"
* name[+].use = #maiden
* name[=].text = "Gross"
* name[=].family = "Gross"
  * extension.url = "http://hl7.org/fhir/StructureDefinition/humanname-own-name"
  * extension.valueString = "Gross"
* address.type = #both
* address.line = "Schmiedegasse 16"
  * extension[0].url = "http://hl7.org/fhir/StructureDefinition/iso21090-ADXP-houseNumber"
  * extension[=].valueString = "16"
  * extension[+].url = "http://hl7.org/fhir/StructureDefinition/iso21090-ADXP-streetName"
  * extension[=].valueString = "Schmiedegasse"
* address.city = "Potsdam"
* address.postalCode = "14469"
* address.country = "DE"
* gender = #male
* birthDate.extension.url = "http://hl7.org/fhir/StructureDefinition/data-absent-reason"
* birthDate.extension.valueCode = #masked
* qualification.code.coding.version = "http://snomed.info/sct/900000000000207008/version/20200131"
* qualification.code.coding = $sct#112247003 "Medical doctor (occupation)"

Invariant: prac-de-1
Description: "Die amtliche Differenzierung der Geschlechtsangabe 'other' darf nur gefüllt sein, wenn das Geschlecht 'other' angegeben ist"
Severity: #error
Expression: "gender='other' or gender.extension('http://fhir.de/StructureDefinition/gender-amtlich-de').empty()"