//Copyright (C) 2012 Potix Corporation. All Rights Reserved.
//History: Thu, Apr 05, 2012 11:25:25 AM
// Author: tomyeh

/**
 * A DOM query agent used to provide the additional utilities
 * for handling DOM.
 */
class DomQuery {
	final node;

	DomQuery(var v) :
	node = v is String ? document.query(v): v is View ? v.node: v {
	}

	/** Returns the inner width of the given element.
	 */
	int get innerWidth()
	=> node is Window ? node.innerWidth: node.$dom_clientWidth;
	/** Returns the inner width of the given element.
	 */
	int get innerHeight()
	=> node is Window ? node.innerHeight: node.$dom_clientHeight;


	/** Returns the offset of this node related to the document.
	 */
	Offset get documentOffset() {
		final Offset ofs = new Offset(0, 0);
		Element el = node;
		do {
			ofs.left += el.$dom_offsetLeft;
			ofs.top += el.$dom_offsetTop;
		} while (el.style.position != "fixed" && (el = el.offsetParent) != null);
		//Note: no need to add widnow's innerLeft/Top if position is fixed.
		//reason: we don't allow window-level scrolling (rather, rootView is scrolled)
		return ofs;
	}
	/** Returns the final used values of all the CSS properties
	 */
	CSSStyleDeclaration get computedStyle() 
	=> window.$dom_getComputedStyle(node, "");
	/** Returns the width of the border.
	 */
	int get borderWidth() {
		String wd = computedStyle.borderWidth;
		return wd !== null && !wd.isEmpty() ?
			Math.parseInt(_reNum.firstMatch(wd).group(0)): 0;
	}
	static final RegExp _reNum = const RegExp(@"([0-9]*)");
}