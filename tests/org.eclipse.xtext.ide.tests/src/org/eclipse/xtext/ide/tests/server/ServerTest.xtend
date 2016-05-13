/*******************************************************************************
 * Copyright (c) 2016 TypeFox GmbH (http://www.typefox.io) and others.
 * All rights reserved. This program and the accompanying materials
 * are made available under the terms of the Eclipse Public License v1.0
 * which accompanies this distribution, and is available at
 * http://www.eclipse.org/legal/epl-v10.html
 *******************************************************************************/
package org.eclipse.xtext.ide.tests.server

import com.google.inject.Inject
import io.typefox.lsapi.DidChangeWatchedFilesParamsImpl
import io.typefox.lsapi.FileEvent
import io.typefox.lsapi.FileEventImpl
import io.typefox.lsapi.InitializeParamsImpl
import org.eclipse.xtext.ide.tests.testlanguage.TestLanguageStandaloneSetup
import org.eclipse.xtext.resource.FileExtensionProvider
import org.eclipse.xtext.resource.IResourceServiceProvider
import org.junit.Test

import static org.junit.Assert.*

/**
 * @author Sven Efftinge - Initial contribution and API
 */
class ServerTest extends AbstractLanguageServerTest {
    
    @Inject def voidRegisterTestLanguage(IResourceServiceProvider.Registry registry) {
        val injector = new TestLanguageStandaloneSetup().createInjectorAndDoEMFRegistration
        registry.extensionToFactoryMap.put(injector.getInstance(FileExtensionProvider).primaryFileExtension, injector.getInstance(IResourceServiceProvider))   
    }
    
    @Test
    def void testInitializeBuild() {
        'MyType1.testlang' -> '''
            type Test {
                string foo
            }
        '''
    	languageServer.initialize(new InitializeParamsImpl => [
    	    rootPath = root.absolutePath
    	])
    	assertTrue(diagnostics.entrySet.join(','), diagnostics.values.head.empty)
    }
    
    @Test
    def void testInitializeBuildWithError() {
        'MyType1.testlang' -> '''
            type Test {
                NonExisting foo
            }
        '''
    	languageServer.initialize(new InitializeParamsImpl => [
    	    rootPath = root.absolutePath
    	])
    	assertEquals("Couldn't resolve reference to TypeDeclaration 'NonExisting'.", diagnostics.values.head.head?.message)
    }
    
    @Test
    def void testIncrementalBuildWithError() {
        'MyType1.testlang' -> '''
            type Test {
                NonExisting foo
            }
        '''
    	languageServer.initialize(new InitializeParamsImpl => [
    	    rootPath = root.absolutePath
    	])
    	assertEquals("Couldn't resolve reference to TypeDeclaration 'NonExisting'.", diagnostics.values.head.head.message)
    	
        val path = 'MyType2.testlang' -> '''
            type NonExisting {
            }
        '''
    	languageServer.getWorkspaceService.didChangeWatchedFiles(new DidChangeWatchedFilesParamsImpl => [
    	    changes = newArrayList(new FileEventImpl => [
    	        uri = path
    	        type = FileEvent.TYPE_CREATED
    	    ])
    	])
    	assertNotNull(diagnostics.get(path))
    	assertTrue(diagnostics.values.join(','), diagnostics.values.forall[empty])
    }
    
}