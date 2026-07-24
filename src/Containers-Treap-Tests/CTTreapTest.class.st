Class {
	#name : 'CTTreapTest',
	#superclass : 'TestCase',
	#instVars : [
		'treap'
	],
	#category : 'Containers-Treap-Tests',
	#package : 'Containers-Treap-Tests'
}

{ #category : 'running' }
CTTreapTest >> setUp [
	super setUp.
	treap := CTTreap new.
]

{ #category : 'tests' }
CTTreapTest >> testAdversarialBounds [
	"Insert 100,000 sequential keys to mathematically prove the randomized O(log N) balance"
	
	1 to: 100000 do: [ :i | treap at: i put: i ].
	
	self assert: treap size equals: 100000.
	
	"If it degraded to O(N), depth would be 100,000. We assert it stays bounded."
	self assert: treap depth < 60.
]

{ #category : 'tests' }
CTTreapTest >> testAtRank [
	treap at: 50 put: 'A'.
	treap at: 20 put: 'B'.
	treap at: 80 put: 'C'.
	treap at: 10 put: 'D'.
	treap at: 30 put: 'E'.
	
	"Sorted Keys: 10, 20, 30, 50, 80"
	self assert: (treap atRank: 1) equals: 'D'. 
	self assert: (treap atRank: 3) equals: 'E'. 
	self assert: (treap atRank: 5) equals: 'C'.
]

{ #category : 'tests' }
CTTreapTest >> testBSTProperty [
	| keys |
	treap at: 50 put: 'A'.
	treap at: 20 put: 'B'.
	treap at: 80 put: 'C'.
	treap at: 10 put: 'D'.
	
	keys := OrderedCollection new.
	treap keysAndValuesDo: [ :k :v | keys add: k ].
	
	self assert: keys asArray equals: #(10 20 50 80).
]

{ #category : 'tests' }
CTTreapTest >> testBasicInsertionAndLookup [
	treap at: 10 put: 'A'.
	treap at: 20 put: 'B'.
	treap at: 5 put: 'C'.

	self assert: treap size equals: 3.
	self assert: (treap at: 10) equals: 'A'.
	self assert: (treap at: 20) equals: 'B'.
	self assert: (treap at: 5) equals: 'C'.
]

{ #category : 'tests' }
CTTreapTest >> testClear [
	treap at: 10 put: 'A'.
	treap at: 20 put: 'B'.
	
	treap clear.
	
	self assert: treap isEmpty.
	self assert: treap size equals: 0.
	self should: [ treap at: 10 ] raise: KeyNotFound.
]

{ #category : 'tests' }
CTTreapTest >> testEmptyTree [
	self assert: treap isEmpty.
	self assert: treap size equals: 0.
	self should: [ treap at: 99 ] raise: KeyNotFound.
	self should: [ treap removeKey: 99 ] raise: KeyNotFound.
]

{ #category : 'tests' }
CTTreapTest >> testHeapProperty [
	treap at: 50 put: 'A'.
	treap at: 20 put: 'B'.
	treap at: 80 put: 'C'.
	treap at: 10 put: 'D'.
	treap at: 90 put: 'E'.
	treap at: 45 put: 'F'.
	
	self assert: (self verifyHeapInvariant: treap root).
]

{ #category : 'tests' }
CTTreapTest >> testRankOutOfBounds [
	treap at: 10 put: 'A'.
	treap at: 20 put: 'B'.
	
	self should: [ treap atRank: 0 ] raise: SubscriptOutOfBounds.
	self should: [ treap atRank: 3 ] raise: SubscriptOutOfBounds.
]

{ #category : 'tests' }
CTTreapTest >> testRemoval [
	treap at: 10 put: 'A'.
	treap at: 20 put: 'B'.
	
	treap removeKey: 10.
	
	self assert: treap size equals: 1.
	self should: [ treap at: 10 ] raise: KeyNotFound.
	self assert: (treap at: 20) equals: 'B'.
]

{ #category : 'tests' }
CTTreapTest >> testRemoveNonExistentKey [
	treap at: 10 put: 'A'.
	
	self assert: (treap removeKey: 99 ifAbsent: [ 'Missing' ]) equals: 'Missing'.
	self assert: treap size equals: 1.
	self assert: (self verifyHeapInvariant: treap root).
]

{ #category : 'tests' }
CTTreapTest >> testStressInterleavedOperations [
	| random keysToRemove previousKey |
	random := Random new.
	keysToRemove := OrderedCollection new.
	
	"Insert 1,000 random elements"
	1 to: 1000 do: [ :i | 
		| k |
		k := random nextInteger: 10000.
		treap at: k put: i.
		"pick some keys to delete later"
		(i \\ 2 = 0) ifTrue: [ keysToRemove add: k ] ].
		
	"Remove the selected keys"
	keysToRemove do: [ :k | treap removeKey: k ifAbsent: [] ].
	
	"Verify the Max-Heap invariant survived"
	self assert: (self verifyHeapInvariant: treap root).
	
	"Verify the BST invariant (ascending order) survived"
	previousKey := -1.
	treap keysAndValuesDo: [ :k :v | 
		self assert: k > previousKey.
		previousKey := k ].
]

{ #category : 'tests' }
CTTreapTest >> testUpdateExistingKey [
	treap at: 10 put: 'Initial'.
	treap at: 10 put: 'Updated'.
	
	self assert: treap size equals: 1.
	self assert: (treap at: 10) equals: 'Updated'.
]

{ #category : 'private' }
CTTreapTest >> verifyHeapInvariant: aNode [
	aNode isEmptyNode ifTrue: [ ^ true ].
	
	aNode leftChild isEmptyNode ifFalse: [
		aNode priority <= aNode leftChild priority ifTrue: [ ^ false ].
		(self verifyHeapInvariant: aNode leftChild) ifFalse: [ ^ false ] ].
		
	aNode rightChild isEmptyNode ifFalse: [
		aNode priority <= aNode rightChild priority ifTrue: [ ^ false ].
		(self verifyHeapInvariant: aNode rightChild) ifFalse: [ ^ false ] ].
		
	^ true
]
