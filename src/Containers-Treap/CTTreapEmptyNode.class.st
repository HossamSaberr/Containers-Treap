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

{ #category : 'operations' }
CTTreapEmptyNode >> mergeWith: aRightTreap [
	"Merging nothing with a right tree just yields the right tree"
	^ aRightTreap

]

{ #category : 'operations' }
CTTreapEmptyNode >> mergedFromLeftNode: aLeftTreap [
	"merging a left tree with nothing yields the left tree"
	^ aLeftTreap

]

{ #category : 'operations' }
CTTreapEmptyNode >> split: aKey [
	"Splitting nothing yields two nothings"
	^ { self . self }

]
