Class {
	#name : 'CTTreapInsertBenchmark',
	#superclass : 'CTTreapAbstractBenchmark',
	#instVars : [
		'sortedData'
	],
	#category : 'Containers-Treap-Benchmarks',
	#package : 'Containers-Treap-Benchmarks'
}

{ #category : 'running' }
CTTreapInsertBenchmark >> run [
	sortedData do: [ :each | treap at: each put: each ]
]

{ #category : 'running' }
CTTreapInsertBenchmark >> setUp [
	super setUp.
	sortedData := (1 to: 100000) asArray.

]
