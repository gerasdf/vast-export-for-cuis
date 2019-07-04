'From Cuis 5.0 of 7 November 2016 [latest update: #3795] on 4 July 2019 at 1:34:43 am'!
'Description '!
!provides: 'VAST-Exporter' 1 1!
SystemOrganization addCategory: #'VAST-Exporter'!


!classDefinition: #VASTExporterTest category: #'VAST-Exporter'!
TestCase subclass: #VASTExporterTest
	instanceVariableNames: 'exporter'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'VAST-Exporter'!
!classDefinition: 'VASTExporterTest class' category: #'VAST-Exporter'!
VASTExporterTest class
	instanceVariableNames: ''!

!classDefinition: #VASTExporter category: #'VAST-Exporter'!
Object subclass: #VASTExporter
	instanceVariableNames: 'package vastName'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'VAST-Exporter'!
!classDefinition: 'VASTExporter class' category: #'VAST-Exporter'!
VASTExporter class
	instanceVariableNames: ''!


!VASTExporterTest methodsFor: 'testing' stamp: 'gera 7/4/2019 01:33:46'!
testName
	self assert: exporter package packageName equals: 'VAST-Exporter'! !

!VASTExporterTest methodsFor: 'initialization' stamp: 'gera 7/4/2019 01:33:59'!
setUp
	exporter := VASTExporter forPackageNamed: 'VAST-Exporter' as: 'VASTExporterApp'! !

!VASTExporter methodsFor: 'accessing' stamp: 'gera 7/4/2019 01:34:22'!
package
	"Answer the value of package"

	^ package! !

!VASTExporter methodsFor: 'accessing' stamp: 'gera 7/4/2019 01:34:23'!
package: anObject
	"Set the value of package"

	package _ anObject! !

!VASTExporter methodsFor: 'accessing' stamp: 'gera 7/4/2019 01:31:57'!
vastName
	"Answer the value of vastName"

	^ vastName! !

!VASTExporter methodsFor: 'accessing' stamp: 'gera 7/4/2019 01:31:57'!
vastName: anObject
	"Set the value of vastName"

	vastName _ anObject! !

!VASTExporter class methodsFor: 'as yet unclassified' stamp: 'gera 7/4/2019 01:31:20'!
forPackageNamed: aString as: vastName
	| package |
	package := CodePackage installedPackages at: aString.
	^self new
		package: package;
		vastName: vastName;
		yourself
	! !
