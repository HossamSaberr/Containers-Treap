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
