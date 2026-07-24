Class {
	#name : 'CTTreapAbstractBenchmark',
	#superclass : 'Object',
	#instVars : [
		'treap'
	],
	#category : 'Containers-Treap-Benchmarks',
	#package : 'Containers-Treap-Benchmarks'
}

{ #category : 'running' }
CTTreapAbstractBenchmark >> run [
	^ self subclassResponsibility
]

{ #category : 'running' }
CTTreapAbstractBenchmark >> setUp [
	treap := CTTreap new.

]
