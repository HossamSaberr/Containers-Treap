Class {
	#name : 'CTTreap',
	#superclass : 'Object',
	#instVars : [
		'root',
		'size',
		'randomGenerator'
	],
	#category : 'Containers-Treap',
	#package : 'Containers-Treap'
}

{ #category : 'accessing' }
CTTreap >> at: aKey [
	^ self at: aKey ifAbsent: [ KeyNotFound signalFor: aKey ]
	
]

{ #category : 'accessing' }
CTTreap >> at: aKey ifAbsent: aBlock [
	"Use the safe lookup instead of the destructive update"
	^ root lookupKey: aKey ifAbsent: aBlock
]

{ #category : 'accessing' }
CTTreap >> at: aKey put: aValue [
	"If the key updates successfully, we are done. If absent, we build and insert a new node."
	root updateKey: aKey value: aValue ifAbsent: [ self insertNewKey: aKey value: aValue ].
	^ aValue

]

{ #category : 'accessing' }
CTTreap >> depth [
	^ root depth
	
]

{ #category : 'testing' }
CTTreap >> includesKey: aKey [
	| found |
	found := true.
	self at: aKey ifAbsent: [ found := false ].
	^ found
	
]

{ #category : 'initialization' }
CTTreap >> initialize [
	super initialize.
	size := 0.
	randomGenerator := Random new.
	root := CTTreapEmptyNode new.
]

{ #category : 'removing' }
CTTreap >> insertNewKey: aKey value: aValue [
	| newNode splits |
	newNode := CTTreapNode new 
		key: aKey 
		value: aValue 
		priority: randomGenerator next.
		
	splits := root split: aKey.
	root := (splits first mergeWith: newNode) mergeWith: splits second.
	size := size + 1.

]

{ #category : 'testing' }
CTTreap >> isEmpty [
	^ size = 0
]

{ #category : 'removing' }
CTTreap >> removeKey: aKey [
	^ self removeKey: aKey ifAbsent: [ KeyNotFound signalFor: aKey ]
	
]

{ #category : 'removing' }
CTTreap >> removeKey: aKey ifAbsent: aBlock [
	(self includesKey: aKey) ifFalse: [ ^ aBlock value ].
	root := root removeKey: aKey.
	size := size - 1.
	^ aKey
	
]

{ #category : 'accessing' }
CTTreap >> root [
	^ root

]

{ #category : 'accessing' }
CTTreap >> root: aNode [
	root := aNode
]

{ #category : 'accessing' }
CTTreap >> size [
	^ size

]
