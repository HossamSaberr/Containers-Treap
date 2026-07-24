Class {
	#name : 'CTTreapNode',
	#superclass : 'Object',
	#instVars : [
		'key',
		'value',
		'priority',
		'leftChild',
		'rightChild',
		'subtreeSize'
	],
	#category : 'Containers-Treap',
	#package : 'Containers-Treap'
}

{ #category : 'accessing' }
CTTreapNode >> depth [
	^ 1 + (leftChild depth max: rightChild depth)
]

{ #category : 'testing' }
CTTreapNode >> isEmptyNode [
	^ false
]

{ #category : 'accessing' }
CTTreapNode >> key [
	^ key
]

{ #category : 'initialization' }
CTTreapNode >> key: aKey value: aValue priority: aPriority [
	key := aKey.
	value := aValue.
	priority := aPriority.
	leftChild := CTTreapEmptyNode new.
	rightChild := CTTreapEmptyNode new.
	subtreeSize := 1.
]

{ #category : 'accessing' }
CTTreapNode >> leftChild [
	^ leftChild

]

{ #category : 'accessing' }
CTTreapNode >> leftChild: aNode [
	leftChild := aNode.
	self updateSubtreeSize.

]

{ #category : 'accessing' }
CTTreapNode >> lookupKey: aKey ifAbsent: aBlock [
	key = aKey ifTrue: [ ^ value ].
	^ key < aKey 
		ifTrue: [ rightChild lookupKey: aKey ifAbsent: aBlock ] 
		ifFalse: [ leftChild lookupKey: aKey ifAbsent: aBlock ]
]

{ #category : 'operations' }
CTTreapNode >> mergeWith: aRightTreap [
	^ aRightTreap mergedFromLeftNode: self
]

{ #category : 'operations' }
CTTreapNode >> mergedFromLeftNode: aLeftTreap [
	"The right tree evaluates priorities and directs the pointers"
	aLeftTreap priority > self priority ifTrue: [ 
		aLeftTreap rightChild: (aLeftTreap rightChild mergeWith: self).
		^ aLeftTreap 
	] ifFalse: [ 
		self leftChild: (aLeftTreap mergeWith: leftChild).
		^ self 
	]

]

{ #category : 'enumerating' }
CTTreapNode >> nodeAtRank: anInteger [
	| leftSize |
	leftSize := leftChild subtreeSize.
	anInteger = (leftSize + 1) ifTrue: [ ^ self ].
	
	^ anInteger <= leftSize
		ifTrue: [ leftChild nodeAtRank: anInteger ]
		ifFalse: [ rightChild nodeAtRank: (anInteger - leftSize - 1) ]
]

{ #category : 'operations' }
CTTreapNode >> removeKey: aKey [
	key = aKey ifTrue: [ ^ leftChild mergeWith: rightChild ].
	
	key < aKey 
		ifTrue: [ self rightChild: (rightChild removeKey: aKey) ] 
		ifFalse: [ self leftChild: (leftChild removeKey: aKey) ].
	^ self
]

{ #category : 'accessing' }
CTTreapNode >> rightChild [
	^ rightChild

]

{ #category : 'accessing' }
CTTreapNode >> rightChild: aNode [
	rightChild := aNode.
	self updateSubtreeSize.

]

{ #category : 'operations' }
CTTreapNode >> split: aKey [
	| splits |
	key <= aKey ifTrue: [ 
		splits := rightChild split: aKey.
		self rightChild: splits first.
		^ { self . splits second }
	] ifFalse: [ 
		splits := leftChild split: aKey.
		self leftChild: splits second.
		^ { splits first . self }
	]
]

{ #category : 'accessing' }
CTTreapNode >> subtreeSize [
	^ subtreeSize

]

{ #category : 'operations' }
CTTreapNode >> updateKey: aKey value: aValue ifAbsent: aBlock [
	key = aKey ifTrue: [ 
		value := aValue. 
		^ aValue ].
		
	^ key < aKey 
		ifTrue: [ rightChild updateKey: aKey value: aValue ifAbsent: aBlock ] 
		ifFalse: [ leftChild updateKey: aKey value: aValue ifAbsent: aBlock ]
]

{ #category : 'private' }
CTTreapNode >> updateSubtreeSize [
	subtreeSize := 1 + leftChild subtreeSize + rightChild subtreeSize.
]

{ #category : 'accessing' }
CTTreapNode >> value [
	^ value
	
]

{ #category : 'accessing' }
CTTreapNode >> value: aValue [
	value := aValue
]
