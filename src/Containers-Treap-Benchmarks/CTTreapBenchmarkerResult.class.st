Class {
	#name : 'CTTreapBenchmarkerResult',
	#superclass : 'Object',
	#instVars : [
		'executionTime',
		'fullGCTime',
		'incrementalGCTime'
	],
	#category : 'Containers-Treap-Benchmarks',
	#package : 'Containers-Treap-Benchmarks'
}

{ #category : 'accessing' }
CTTreapBenchmarkerResult >> executionTime [
	^ executionTime
]

{ #category : 'accessing' }
CTTreapBenchmarkerResult >> executionTime: aDuration [
	executionTime := aDuration
]

{ #category : 'accessing' }
CTTreapBenchmarkerResult >> fullGCTime [
	^ fullGCTime
]

{ #category : 'accessing' }
CTTreapBenchmarkerResult >> fullGCTime: aDuration [
	fullGCTime := aDuration
]

{ #category : 'accessing' }
CTTreapBenchmarkerResult >> incrementalGCTime [
	^ incrementalGCTime
]

{ #category : 'accessing' }
CTTreapBenchmarkerResult >> incrementalGCTime: aDuration [
	incrementalGCTime := aDuration
]
