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
CTTreapTest >> testUpdateExistingKey [
	treap at: 10 put: 'Initial'.
	treap at: 10 put: 'Updated'.
	
	self assert: treap size equals: 1.
	self assert: (treap at: 10) equals: 'Updated'.
]
