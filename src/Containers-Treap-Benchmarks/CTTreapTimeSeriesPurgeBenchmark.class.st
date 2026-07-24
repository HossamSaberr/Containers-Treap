Class {
	#name : 'CTTreapTimeSeriesPurgeBenchmark',
	#superclass : 'CTTreapAbstractBenchmark',
	#instVars : [
		'timestamps',
		'expirationThreshold'
	],
	#category : 'Containers-Treap-Benchmarks',
	#package : 'Containers-Treap-Benchmarks'
}

{ #category : 'running' }
CTTreapTimeSeriesPurgeBenchmark >> run [
	| root splits activeDatabase |
	"Ingest the chaotic telemetry data"
	timestamps do: [ :time | treap at: time put: time ].
	
	"Instantly purge ALL data older than the threshold in O(log N)"
	root := treap root.
	splits := root split: expirationThreshold.
	
	"The right subtree contains only the non expired data"
	activeDatabase := splits second.
	treap root: activeDatabase.
]

{ #category : 'running' }
CTTreapTimeSeriesPurgeBenchmark >> setUp [
	| random |
	super setUp.
	random := Random new.
	"Simulate 100,000 highly chaotic, out-of-order IoT sensor timestamps"
	timestamps := (1 to: 100000) collect: [ :i | random nextInteger: 500000 ].
	expirationThreshold := 250000.

]
