Class {
	#name : 'CTTreapEmptyNode',
	#superclass : 'Object',
	#category : 'Containers-Treap',
	#package : 'Containers-Treap'
}

{ #category : 'accessing' }
CTTreapEmptyNode >> depth [
	^ 0

]

{ #category : 'testing' }
CTTreapEmptyNode >> isEmptyNode [
	^ true
]
