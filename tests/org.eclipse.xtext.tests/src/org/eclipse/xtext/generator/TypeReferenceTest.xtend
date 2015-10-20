/*******************************************************************************
 * Copyright (c) 2015 itemis AG (http://www.itemis.eu) and others.
 * All rights reserved. This program and the accompanying materials
 * are made available under the terms of the Eclipse Public License v1.0
 * which accompanies this distribution, and is available at
 * http://www.eclipse.org/legal/epl-v10.html
 *******************************************************************************/
package org.eclipse.xtext.generator

import org.junit.Test

import static org.junit.Assert.*

import static extension org.eclipse.xtext.xtext.generator.model.TypeReference.*

class TypeReferenceTest {
	
	/*
	 * See https://bugs.eclipse.org/bugs/show_bug.cgi?id=480196
	 */
	@Test
	def void testDefaultPackage() {
		val ref = "EString".typeRef
		assertEquals("", ref.packageName)
		assertEquals("EString", ref.simpleName)
	}
	
	@Test
	def void testPackageName() {
		val ref = "org.example.MyType".typeRef
		assertEquals("MyType", ref.simpleName)
		assertEquals("org.example", ref.packageName)
	}
	
	@Test
	def void testParametrizedType() {
		val ref = "java.util.List".typeRef("String".typeRef)
		assertEquals("List", ref.simpleName)
		assertEquals("java.util", ref.packageName)
		assertEquals("String", ref.typeArguments.head.simpleName)
	}
	
	@Test
	def void testNestedType() {
		val ref = "java.util.Map.Entry".typeRef
		assertEquals("java.util", ref.packageName)
		assertEquals("Entry", ref.simpleName)
		assertEquals(#["Map", "Entry"], ref.simpleNames)
	}
	
	@Test
	def void testJavaPath() {
		val ref = "org.example.MyType".typeRef
		assertEquals("org/example/MyType.java", ref.javaPath)
	}
	
	@Test
	def void testXtendPath() {
		val ref = "org.example.MyType".typeRef
		assertEquals("org/example/MyType.xtend", ref.xtendPath)
	}
}