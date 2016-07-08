/*
 * generated by Xtext
 */
package org.eclipse.xtext.enumrules.parser.antlr;

import com.google.inject.Inject;

import org.eclipse.xtext.parser.antlr.XtextTokenStream;
import org.eclipse.xtext.enumrules.services.EnumAndReferenceTestLanguageGrammarAccess;

public class EnumAndReferenceTestLanguageParser extends org.eclipse.xtext.parser.antlr.AbstractAntlrParser {
	
	@Inject
	private EnumAndReferenceTestLanguageGrammarAccess grammarAccess;
	
	@Override
	protected void setInitialHiddenTokens(XtextTokenStream tokenStream) {
		tokenStream.setInitialHiddenTokens("RULE_WS", "RULE_ML_COMMENT", "RULE_SL_COMMENT");
	}
	
	@Override
	protected org.eclipse.xtext.enumrules.parser.antlr.internal.InternalEnumAndReferenceTestLanguageParser createParser(XtextTokenStream stream) {
		return new org.eclipse.xtext.enumrules.parser.antlr.internal.InternalEnumAndReferenceTestLanguageParser(stream, getGrammarAccess());
	}
	
	@Override 
	protected String getDefaultRuleName() {
		return "EntityWithEnumAndReference";
	}
	
	public EnumAndReferenceTestLanguageGrammarAccess getGrammarAccess() {
		return this.grammarAccess;
	}
	
	public void setGrammarAccess(EnumAndReferenceTestLanguageGrammarAccess grammarAccess) {
		this.grammarAccess = grammarAccess;
	}
	
}