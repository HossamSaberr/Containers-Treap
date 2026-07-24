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

{ #category : 'operations' }
CTTreapNode >> removeKey: aKey [
	key = aKey ifTrue: [ ^ leftChild mergeWith: rightChild ].
	
	key < aKey 
		ifTrue: [ self rightChild: (rightChild removeKey: aKey) ] 
		ifFalse: [ self leftChild: (leftChild removeKey: aKey) ].
	^ self
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
