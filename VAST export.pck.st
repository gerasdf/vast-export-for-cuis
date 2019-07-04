'From Cuis 5.0 of 7 November 2016 [latest update: #3795] on 3 July 2019 at 11:29:09 pm'!
'Description '!
!provides: 'VAST export' 1 3!
SystemOrganization addCategory: #'VAST export'!


!classDefinition: #VASTExportCodePackage category: #'VAST export'!
CodePackage subclass: #VASTExportCodePackage
	instanceVariableNames: 'vastName'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'VAST export'!
!classDefinition: 'VASTExportCodePackage class' category: #'VAST export'!
VASTExportCodePackage class
	instanceVariableNames: ''!


!VASTExportCodePackage methodsFor: 'as yet unclassified' stamp: 'gera 7/3/2019 22:56:50'!
vastName: aString
	vastName := aString! !

!VASTExportCodePackage methodsFor: 'vast format' stamp: 'gera 7/3/2019 23:23:09'!
writeFeatureSpecOn: aStream
	| chunk |
	chunk := String streamContents: [:strm |
		strm
			nextPutAll: 'Application create: #', vastName, ' with:'; newLine;
			nextPutAll: '    (#('.
"		featureSpec requires do: [ :requires |
			strm space; nextPutAll: requires name asString printString].
"		strm nextPutAll: ' Kernel'.
		strm
			nextPut: $); newLine;
			nextPutAll: '        collect: [:each | Smalltalk at: each ifAbsent: ['; newLine;
			nextPutAll: '            Application errorPrerequisite: #', vastName, ' missing: each]])'.
	].	
	
	aStream nextChunkPut: chunk; newLine.
! !

!VASTExportCodePackage methodsFor: 'vast format' stamp: 'gera 7/3/2019 23:29:05'!
writeSystemCategoriesOn: aStream
	" nothing in the name of System Categories, I think "! !

!VASTExportCodePackage class methodsFor: 'instance creation' stamp: 'gera 7/3/2019 21:41:03'!
from: aCodePackage
	^self new copyFrom: aCodePackage! !
VASTExportCodePackage prePackageInstall!
!classDefinition: #VASTExportCodePackage category: #'VAST export'!
CodePackage subclass: #VASTExportCodePackage
	instanceVariableNames: 'vastName'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'VAST export'!
!classDefinition: 'VASTExportCodePackage class' category: #'VAST export'!
VASTExportCodePackage class
	instanceVariableNames: ''!


!VASTExportCodePackage methodsFor: 'as yet unclassified' stamp: 'gera 7/3/2019 22:56:50'!
vastName: aString
	vastName := aString! !

!VASTExportCodePackage methodsFor: 'vast format' stamp: 'gera 7/3/2019 23:23:09'!
writeFeatureSpecOn: aStream
	| chunk |
	chunk := String streamContents: [:strm |
		strm
			nextPutAll: 'Application create: #', vastName, ' with:'; newLine;
			nextPutAll: '    (#('.
"		featureSpec requires do: [ :requires |
			strm space; nextPutAll: requires name asString printString].
"		strm nextPutAll: ' Kernel'.
		strm
			nextPut: $); newLine;
			nextPutAll: '        collect: [:each | Smalltalk at: each ifAbsent: ['; newLine;
			nextPutAll: '            Application errorPrerequisite: #', vastName, ' missing: each]])'.
	].	
	
	aStream nextChunkPut: chunk; newLine.
! !

!VASTExportCodePackage methodsFor: 'vast format' stamp: 'gera 7/3/2019 23:29:05'!
writeSystemCategoriesOn: aStream
	" nothing in the name of System Categories, I think "! !

!VASTExportCodePackage class methodsFor: 'instance creation' stamp: 'gera 7/3/2019 21:41:03'!
from: aCodePackage
	^self new copyFrom: aCodePackage! !
VASTExportCodePackage postPackageInstall!
