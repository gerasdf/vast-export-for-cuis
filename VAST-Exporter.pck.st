'From Cuis 5.0 of 7 November 2016 [latest update: #3795] on 4 July 2019 at 1:43:19 am'!
'Description '!
!provides: 'VAST-Exporter' 1 2!
SystemOrganization addCategory: #'VAST-Exporter'!


!classDefinition: #VASTExporterTest category: #'VAST-Exporter'!
TestCase subclass: #VASTExporterTest
	instanceVariableNames: 'package exporter'
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


!VASTExporterTest methodsFor: 'testing' stamp: 'gera 7/4/2019 01:37:11'!
testFeatureSpec
	| spec |
	spec := String streamContents: [:strm | exporter writeFeatureSpecOn: strm].
	self assert: false! !

!VASTExporterTest methodsFor: 'testing' stamp: 'gera 7/4/2019 01:42:43'!
testName
	self assert: 'VAST-Exporter-TestPackage' equals: exporter package packageName! !

!VASTExporterTest methodsFor: 'initialization' stamp: 'gera 7/4/2019 01:41:51'!
setUp
	package := CodePackage new packageName: 'VAST-Exporter-TestPackage'.
	exporter := VASTExporter new
		package: package;
		vastName: 'VASTExporterTestPackageApp'! !

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
