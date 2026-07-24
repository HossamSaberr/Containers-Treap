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
CTTreap >> depth [
	^ root depth
	
]

{ #category : 'initialization' }
CTTreap >> initialize [
	super initialize.
	size := 0.
	randomGenerator := Random new.
	root := CTTreapEmptyNode new.
]

{ #category : 'testing' }
CTTreap >> isEmpty [
	^ size = 0
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
