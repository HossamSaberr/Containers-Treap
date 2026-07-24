Class {
	#name : 'CTTreapDynamicStatisticsBenchmark',
	#superclass : 'CTTreapAbstractBenchmark',
	#instVars : [
		'dataStream'
	],
	#category : 'Containers-Treap-Benchmarks',
	#package : 'Containers-Treap-Benchmarks'
}

{ #category : 'running' }
CTTreapDynamicStatisticsBenchmark >> run [
	| median |
	dataStream do: [ :each | 
		treap at: each put: each.
		"Dynamically fetch the median in O(log N) time instantly"
		median := treap atRank: ((treap size // 2) max: 1).
	]
]

{ #category : 'running' }
CTTreapDynamicStatisticsBenchmark >> setUp [
	| random |
	super setUp.
	random := Random new.
	"Simulate a live data stream of 50,000 chaotic data points"
	dataStream := (1 to: 50000) collect: [ :i | random nextInteger: 1000000 ].

]
