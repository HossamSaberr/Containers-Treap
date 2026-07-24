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

{ #category : 'initialization' }
CTTreap >> initialize [
	super initialize.
	size := 0.
	randomGenerator := Random new.
	root := CTTreapEmptyNode new.
]
