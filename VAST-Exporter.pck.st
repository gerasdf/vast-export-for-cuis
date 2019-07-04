'From Cuis 5.0 of 7 November 2016 [latest update: #3795] on 4 July 2019 at 5:53:34 pm'!
'Description '!
!provides: 'VAST-Exporter' 1 9!
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
	instanceVariableNames: 'package vastName comments'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'VAST-Exporter'!
!classDefinition: 'VASTExporter class' category: #'VAST-Exporter'!
VASTExporter class
	instanceVariableNames: ''!


!VASTExporterTest commentStamp: 'gera 7/4/2019 02:54:26' prior: 0!
This class has a comment so it can be tested!

!VASTExporter commentStamp: 'gera 7/4/2019 03:37:11' prior: 0!
A simple way to export code from Cuis into VAST.

VAST code used as reference:

SubApplication >> fileOutAllApplications: apps includeSubApps: includeSubApps on: aStream
Application >> fileOutCreationOn: aStream
SubApplication >> fileOutDefinitionFor: aClass on: stream
SubApplication >> fileOutMethodsOn: stream

EmFileOutInterface >> fileOutCompiledMethods: methods on: stream
!

!VASTExporterTest methodsFor: 'testing' stamp: 'gera 7/4/2019 03:09:08'!
testClassComment
	| expected actual comment |
	exporter comments: true.
	actual := String streamContents: [:strm |
		exporter write: self class classCommentsOn: strm].
	comment := 'This class has a comment so it can be tested'.
	expected := 'VASTExporterTest comment: ', comment printString, '!!

'.
	self assert: expected equals: actual.! !

!VASTExporterTest methodsFor: 'testing' stamp: 'gera 7/4/2019 02:25:10'!
testClassDefinition
	| expected actual |
	expected := 'TestCase subclass: #VASTExporterTest
	classInstanceVariableNames: ''''
	instanceVariableNames: ''package exporter''
	classVariableNames: ''''
	poolDictionaries: '''''.
	actual := exporter classDefinitionFor: self class.
	self assert: expected equals: actual.! !

!VASTExporterTest methodsFor: 'testing' stamp: 'gera 7/4/2019 03:07:22'!
testClassDefinitions
	| result |
	result := String streamContents: [:strm | 
		exporter write: {VASTExporterTest. VASTExporter} classDefinitionsOn: strm].
	result := result readStream.

	self assert: 'VASTExporterTestPackageApp becomeDefault' equals: result nextChunk.
	self assert: Character newLineCharacter equals: result next.
	self assert:  'TestCase subclass: #VASTExporterTest
	classInstanceVariableNames: ''''
	instanceVariableNames: ''package exporter''
	classVariableNames: ''''
	poolDictionaries: ''''' equals: result nextChunk.
	self assert: Character newLineCharacter equals: result next.

	self assert: Character newLineCharacter equals: result next.
	
	self assert: 'VASTExporterTestPackageApp becomeDefault' equals: result nextChunk.
	self assert: Character newLineCharacter equals: result next.
	self assert:  'Object subclass: #VASTExporter
	classInstanceVariableNames: ''''
	instanceVariableNames: ''package vastName comments''
	classVariableNames: ''''
	poolDictionaries: ''''' equals: result nextChunk.
	self assert: Character newLineCharacter equals: result next.

	self assert: Character newLineCharacter equals: result next.

	self assert: result atEnd! !

!VASTExporterTest methodsFor: 'testing' stamp: 'gera 7/4/2019 02:19:15'!
testDefaultAppChunk
	self assert: 'VASTExporterTestPackageApp becomeDefault' equals: exporter defaultAppChunk ! !

!VASTExporterTest methodsFor: 'testing' stamp: 'gera 7/4/2019 02:04:20'!
testFeatureSpec
	| spec sunit |
	sunit := (CodePackage new packageName: 'SUnit') requirementOfMe.
	package featureSpec requires: sunit.
	spec := String streamContents: [:strm | exporter writeFeatureSpecOn: strm].
	self assert: 'Application create: #VASTExporterTestPackageApp with:
    (#( SUnit)
        collect: [:each | Smalltalk at: each ifAbsent: [
            Application errorPrerequisite: #VASTExporterTestPackageApp missing: each]])!!
' equals: spec

	! !

!VASTExporterTest methodsFor: 'testing' stamp: 'gera 7/4/2019 01:50:32'!
testFeatureSpecEmptyRequires
	| spec |
	spec := String streamContents: [:strm | exporter writeFeatureSpecOn: strm].
	self assert: 'Application create: #VASTExporterTestPackageApp with:
    (#( Kernel)
        collect: [:each | Smalltalk at: each ifAbsent: [
            Application errorPrerequisite: #VASTExporterTestPackageApp missing: each]])!!
' equals: spec

	
! !

!VASTExporterTest methodsFor: 'testing' stamp: 'gera 7/4/2019 02:10:53'!
testFeatureSpecTwo
	| spec req |
	req := (CodePackage new packageName: 'SUnit') requirementOfMe.
	package featureSpec requires: req.
	req := (CodePackage new packageName: 'Matanga') requirementOfMe.
	package featureSpec requires: req.
	spec := String streamContents: [:strm | exporter writeFeatureSpecOn: strm].
	self assert: 'Application create: #VASTExporterTestPackageApp with:
    (#( SUnit Matanga)
        collect: [:each | Smalltalk at: each ifAbsent: [
            Application errorPrerequisite: #VASTExporterTestPackageApp missing: each]])!!
' equals: spec

	! !

!VASTExporterTest methodsFor: 'testing' stamp: 'gera 7/4/2019 01:42:43'!
testName
	self assert: 'VAST-Exporter-TestPackage' equals: exporter package packageName! !

!VASTExporterTest methodsFor: 'initialization' stamp: 'gera 7/4/2019 02:01:07'!
setUp
	package := CodePackage named: 'VAST-Exporter-TestPackage' createIfAbsent: true registerIfNew: false.
	exporter := VASTExporter new
		package: package;
		vastName: 'VASTExporterTestPackageApp'! !

!VASTExporter methodsFor: 'initialization' stamp: 'gera 7/4/2019 03:06:22'!
initialize
	comments := false! !

!VASTExporter methodsFor: 'accessing' stamp: 'gera 7/4/2019 03:07:49'!
comments
	"Answer the value of comments"

	^ comments! !

!VASTExporter methodsFor: 'accessing' stamp: 'gera 7/4/2019 03:07:49'!
comments: anObject
	"Set the value of comments"

	comments _ anObject! !

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

!VASTExporter methodsFor: 'exporting' stamp: 'gera 7/4/2019 02:23:09'!
classDefinitionFor: class
	^String streamContents: [ :strm |
		strm
			nextPutAll: class superclass name;
			nextPutAll: class kindOfSubclass;
			store: class name.
		strm
			newLine;
			tab;
			nextPutAll: 'classInstanceVariableNames: ';
			store: class class instanceVariablesString.
		strm
			newLine;
			tab;
			nextPutAll: 'instanceVariableNames: ';
			store: class instanceVariablesString.
		strm
			newLine;
			tab;
			nextPutAll: 'classVariableNames: ';
			store: class classVariablesString.
		strm
			newLine;
			tab;
			nextPutAll: 'poolDictionaries: ';
			store: class sharedPoolsString]! !

!VASTExporter methodsFor: 'exporting' stamp: 'gera 7/4/2019 02:18:22'!
defaultAppChunk
	^ vastName, ' becomeDefault'! !

!VASTExporter methodsFor: 'exporting' stamp: 'gera 7/4/2019 03:09:35'!
write: class classCommentsOn: aStream
	| comment |
	comments ifTrue: [
		comment := class organization classComment.
		comment isEmpty ifFalse: [
			aStream
				nextChunkPut: class name, ' comment: ', comment storeString; newLine;
				newLine]]! !

!VASTExporter methodsFor: 'exporting' stamp: 'gera 7/4/2019 03:05:08'!
write: sortedClasses classDefinitionsOn: aStream
	sortedClasses
		do: [ :class |
			aStream
				nextChunkPut: self defaultAppChunk; newLine;
				nextChunkPut: (self classDefinitionFor: class); newLine;
				newLine.
			self write: class classCommentsOn: aStream]
		displayingProgress: 'Saving class definitions...'.! !

!VASTExporter methodsFor: 'exporting' stamp: 'gera 7/4/2019 02:09:39'!
writeFeatureSpecOn: aStream
	| chunk requires |
	chunk := String streamContents: [:strm |
		strm
			nextPutAll: 'Application create: #', vastName, ' with:'; newLine;
			nextPutAll: '    (#('.
		requires := package featureSpec requires.
		requires isEmpty
			ifTrue: [strm nextPutAll: ' Kernel']
			ifFalse: [
				requires do: [ :required |
					strm space; nextPutAll: required name asString]].
		strm
			nextPut: $); newLine;
			nextPutAll: '        collect: [:each | Smalltalk at: each ifAbsent: ['; newLine;
			nextPutAll: '            Application errorPrerequisite: #', vastName, ' missing: each]])'.
	].	
	
	aStream nextChunkPut: chunk; newLine.! !

!VASTExporter methodsFor: 'exporting' stamp: 'gera 7/4/2019 02:14:42'!
writeOnStream: aStream
	" This method is based in CodePacket >> #writeOnStream "
	| sortedClasses |
	self writeFeatureSpecOn: aStream.

	"
	package codePackageClass ifNotNil: [ :codePackageClass |
		self
			write: {codePackageClass} classDefinitionsOn: aStream;
			write: {codePackageClass} classCommentsOn: aStream;
			write: {codePackageClass} methodsOn: aStream.
		aStream nextChunkPut: codePackageClass name, ' prePackageInstall'; newLine ].
	"
	
	sortedClasses _ Array streamContents: [ :strm |
		package classesInSafeOrderDo: [ :cls |
			cls == self class ifFalse: [
				strm nextPut: cls ]]].
	self
		write: sortedClasses classDefinitionsOn: aStream;
		write: sortedClasses classCommentsOn: aStream;
		write: sortedClasses methodsForFileinOn: aStream;
		write: sortedClasses methodsOn: aStream.

	package
		sortedExtensionMethodsDo:  [ :methodReference |
			methodReference isValid ifTrue: [
				self writeMethod: methodReference on: aStream ]]
		displayingProgress: 'Saving extension methods...'.
	self write: sortedClasses initializersOn: aStream.

	package codePackageClass ifNotNil: [ :codePackageClass |
		self write: { codePackageClass } initializersOn: aStream.
		aStream nextChunkPut: codePackageClass name, ' postPackageInstall'; newLine ]! !

!VASTExporter class methodsFor: 'as yet unclassified' stamp: 'gera 7/4/2019 01:31:20'!
forPackageNamed: aString as: vastName
	| package |
	package := CodePackage installedPackages at: aString.
	^self new
		package: package;
		vastName: vastName;
		yourself
	! !

!VASTExporter class methodsFor: 'as yet unclassified' stamp: 'gera 7/4/2019 03:06:44'!
new
	^ super new initialize! !
