Class {
	#name : 'BaselineOfContainersTreap',
	#superclass : 'BaselineOf',
	#category : 'BaselineOfContainersTreap',
	#package : 'BaselineOfContainersTreap'
}

{ #category : 'baselines' }
BaselineOfContainersTreap >> baseline: spec [
	<baseline>
	spec for: #common do: [ 
		spec
			package: 'Containers-Treap';
			package: 'Containers-Treap-Tests' with: [ spec requires: #('Containers-Treap') ];
			package: 'Containers-Treap-Benchmarks' with: [ spec requires: #('Containers-Treap') ].

		spec
			group: 'Core' with: #('Containers-Treap');
			group: 'Tests' with: #('Containers-Treap-Tests');
			group: 'Benchmarks' with: #('Containers-Treap-Benchmarks');
			group: 'default' with: #('Core' 'Tests' 'Benchmarks') ]
]
