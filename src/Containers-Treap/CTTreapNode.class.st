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
