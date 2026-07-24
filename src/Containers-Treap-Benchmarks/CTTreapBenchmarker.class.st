Class {
	#name : 'CTTreapBenchmarker',
	#superclass : 'Object',
	#instVars : [
		'blockToExecute'
	],
	#category : 'Containers-Treap-Benchmarks',
	#package : 'Containers-Treap-Benchmarks'
}

{ #category : 'benchmarking' }
CTTreapBenchmarker >> benchmark [
	| executionTime fullGCTime incrementalGCTime |
	
	fullGCTime := Smalltalk vm totalFullGCTime.
	incrementalGCTime := Smalltalk vm totalIncrementalGCTime.
	executionTime := Time primUTCMicrosecondsClock.

	blockToExecute value.
	
	executionTime := Time primUTCMicrosecondsClock - executionTime.
	"Multiply by 1000 to convert millisecond GC time into microseconds"
	fullGCTime := (Smalltalk vm totalFullGCTime - fullGCTime) * 1000.
	incrementalGCTime := (Smalltalk vm totalIncrementalGCTime - incrementalGCTime) * 1000.

	^ CTTreapBenchmarkerResult new
		executionTime: executionTime;
		fullGCTime: fullGCTime;
		incrementalGCTime: incrementalGCTime;
		yourself
]

{ #category : 'accessing' }
CTTreapBenchmarker >> blockToExecute: aBlock [
	blockToExecute := aBlock
]
