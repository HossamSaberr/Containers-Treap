Class {
	#name : 'CTTreapSearchDeleteBenchmark',
	#superclass : 'CTTreapAbstractBenchmark',
	#instVars : [
		'keysToRemove'
	],
	#category : 'Containers-Treap-Benchmarks',
	#package : 'Containers-Treap-Benchmarks'
}

{ #category : 'running' }
CTTreapSearchDeleteBenchmark >> run [
	"delete elements, relying on the Double Dispatch engines"
	keysToRemove do: [ :key | 
		treap removeKey: key ifAbsent: [] 
	]
]

{ #category : 'running' }
CTTreapSearchDeleteBenchmark >> setUp [
	| random |
	super setUp.
	random := Random new.
	1 to: 100000 do: [ :i | treap at: i put: i ].
	"50,000 random targets, some will hit, some will miss"
	keysToRemove := (1 to: 50000) collect: [ :i | random nextInteger: 120000 ].

]
