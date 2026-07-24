Class {
	#name : 'CTTreapSplitMergeBenchmark',
	#superclass : 'CTTreapAbstractBenchmark',
	#instVars : [
		'randomPivotKeys'
	],
	#category : 'Containers-Treap-Benchmarks',
	#package : 'Containers-Treap-Benchmarks'
}

{ #category : 'running' }
CTTreapSplitMergeBenchmark >> run [
	| root splits left right |
	randomPivotKeys do: [ :pivot |
		root := treap root.
		
		"Sever the tree"
		splits := root split: pivot.
		left := splits first.
		right := splits second.
		
		"Instantly fuse it back together"
		treap root: (left mergeWith: right).
	]
]

{ #category : 'running' }
CTTreapSplitMergeBenchmark >> setUp [
	| random |
	super setUp.
	random := Random new.
	"Build the tree"
	1 to: 100000 do: [ :i | treap at: i put: i ].
	"Generate 10,000 random pivot points to split at"
	randomPivotKeys := (1 to: 10000) collect: [ :i | random nextInteger: 100000 ].

]
