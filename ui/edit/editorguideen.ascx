<%@ Control Language="c#" AutoEventWireup="false" Codebehind="EditorGuideEN.ascx.cs" Inherits="EPiServer.Edit.EditorGuideEN" TargetSchema="http://schemas.microsoft.com/intellisense/ie5" %>

<h1>
	Usability Guide
</h1>
<p>
	Here you can read about how you, as an editor, can create usable and accessible content for the Web.
</p>
<p>
	<a href="javascript:displaySection('Section1')" class="EPEdit-editorGuideNavigationHeader"><img src="<%=EPiServer.Global.EPConfig.RootDir%>util/images/EditorGuide/arrowright.gif" />Images and Graphical Elements</a>
	<br />
	<a href="javascript:displaySection('Section2')" class="EPEdit-editorGuideNavigationHeader"><img src="<%=EPiServer.Global.EPConfig.RootDir%>util/images/EditorGuide/arrowright.gif" />Links</a>
	<br />
	<a href="javascript:displaySection('Section3')" class="EPEdit-editorGuideNavigationHeader"><img src="<%=EPiServer.Global.EPConfig.RootDir%>util/images/EditorGuide/arrowright.gif" />Forms</a>
	<br />
	<a href="javascript:displaySection('Section4')" class="EPEdit-editorGuideNavigationHeader"><img src="<%=EPiServer.Global.EPConfig.RootDir%>util/images/EditorGuide/arrowright.gif" />Tables</a>
	<br />
	<a href="javascript:displaySection('Section5')" class="EPEdit-editorGuideNavigationHeader"><img src="<%=EPiServer.Global.EPConfig.RootDir%>util/images/EditorGuide/arrowright.gif" />Text</a>
	<br />
	<a href="javascript:displaySection('Section6')" class="EPEdit-editorGuideNavigationHeader"><img src="<%=EPiServer.Global.EPConfig.RootDir%>util/images/EditorGuide/arrowright.gif" />Colors and Contrasts</a>
</p>
<hr />
<div id="DisplayText">
	<p>
		Click one of the headings above to read about the corresponding subject.
	</p>
</div>

<div id="Section1" class="hidden">
	<h1>
		Images and Graphical Elements
	</h1>
	<h2>
		Add Alternative Texts to Images and Other Graphical Elements
	</h2>
	<p>
		A short alternative description should be added to graphical elements like photos, illustrations, maps, text saved as images, etc. This description is called an alternative text. If you want to check how the alternative texts are displayed, they are shown as yellow squares when you point at the images (using the Internet Explorer Web browser).
	</p>
	<p>
		The alternative text should describe the image and its function. This means that different kinds of images might require more or less extensive descriptions. Below you can read about what applies to some different types of graphical elements.
	</p>
	<p>
		Note that the same image might require different descriptions depending on the context in which it is published. Therefore, you should avoid working with fixed image descriptions.
	</p>
	<h3>	
		<a id="ShowHideLink11" title="<%= EPiServer.Global.EPLang.TranslateForScript("/edit/editorguide/showsection") %>"
		href="javascript:showOrHideSubSection('SubSection11', 'ShowHideImage11', 'ShowHideLink11')">
			<img id="ShowHideImage11" src="<%=EPiServer.Global.EPConfig.RootDir%>util/images/EditorGuide/arrowdown.gif" />Images Used for Decoration
		</a>
	</h3>
	<div id="SubSection11" class="hidden">
		<p>
			Images that are mainly used to brighten up the page have no deeper function, and they should therefore be briefly described. Note! You don't have to write "Image". However, it might be a good idea to write if the image is a photo or an illustration. The alternative text: "Happy children playing in a sandbox. Photo" is a good alternative text for an image used on a page to brighten up a text about a preschool program. 
		</p>
	</div>
	<h3>	
		<a id="ShowHideLink12" title="<%= EPiServer.Global.EPLang.TranslateForScript("/edit/editorguide/showsection") %>"
		href="javascript:showOrHideSubSection('SubSection12', 'ShowHideImage12', 'ShowHideLink12')">
			<img id="ShowHideImage12" src="<%=EPiServer.Global.EPConfig.RootDir%>util/images/EditorGuide/arrowdown.gif" />Content-Rich Image Elements
		</a>
	</h3>
	<div id="SubSection12" class="hidden">
		<p>
			Some images contain information that is essential for the user's comprehension. For instance, this is the case of diagrams, blueprints, exploded views or news images. These require a more accurate and extensive description. Nevertheless, try to limit the description to maximum 150 characters.
		</p>
		<p>
			If the image has to be further explained, you might need to describe it in a separate text. Sometimes this description is found in the text that surrounds the image. In this case, the alternative text can refer to this text.
		</p>
	</div>
	<h3>	
		<a id="ShowHideLink13" title="<%= EPiServer.Global.EPLang.TranslateForScript("/edit/editorguide/showsection") %>"
		href="javascript:showOrHideSubSection('SubSection13', 'ShowHideImage13', 'ShowHideLink13')">
			<img id="ShowHideImage13" src="<%=EPiServer.Global.EPConfig.RootDir%>util/images/EditorGuide/arrowdown.gif" />Image Maps
		</a>
	</h3>
	<div id="SubSection13" class="hidden">
		<p>
			An image map is an image where parts of the image are clickable with links to other pages. This means that the elements, the different parts of the image map, consist of both images and links at the same time. In order for an image map to work, the image should be described using an alternative text. In addition, each link should be described using a supplementary text, a so-called ToolTip. Furthermore, it might be good having ordinary text links next to the image element.
		</p>
		<p>
			Imagine a region map where each county should be clickable. In this case, you describe the region map using an alternative text, and each county link using a ToolTip.
		</p>
	</div>
	<h3>	
		<a id="ShowHideLink14" title="<%= EPiServer.Global.EPLang.TranslateForScript("/edit/editorguide/showsection") %>"
		href="javascript:showOrHideSubSection('SubSection14', 'ShowHideImage14', 'ShowHideLink14')">
			<img id="ShowHideImage14" src="<%=EPiServer.Global.EPConfig.RootDir%>util/images/EditorGuide/arrowdown.gif" />Icons
		</a>
	</h3>
	<div id="SubSection14" class="hidden">
		<p>
			Icons are used to indicate certain special functions, and they should make the function in question clear. Icons should be used sparsely, and standard icons should be used whenever possible. Avoid using icons inside a text section.
		</p>
		<p>
			Icons should be described using an alternative text. If the icon is clickable it should be described both using an alternative text and a ToolTip.
		</p>
	</div>
	<h3>	
		<a id="ShowHideLink15" title="<%= EPiServer.Global.EPLang.TranslateForScript("/edit/editorguide/showsection") %>"
		href="javascript:showOrHideSubSection('SubSection15', 'ShowHideImage15', 'ShowHideLink15')">
			<img id="ShowHideImage15" src="<%=EPiServer.Global.EPConfig.RootDir%>util/images/EditorGuide/arrowdown.gif" />Text Images
		</a>
	</h3>
	<div id="SubSection15" class="hidden">
		<p>
			Avoid using images for presenting pure text. In most cases, "text images" can be replaced by real text. In some cases, changes to the style sheet (CSS) of your Web site might be required in order to make this work.
		</p>
		<p>
			If you still use text images, you have to enter the same text as an alternative text.
		</p>
	</div>
	<h2>
		Graphical Elements without Meaning
	</h2>
	<p>
		If an image's function does not have a meaning, you should not specify an alternative text. Elements without meaning are used to improve the visual presentation on the page, e.g. typographic lines, dots, etc.
	</p>
	<h2>
		Why Is This Important?
	</h2>
	<p>
		The equipment that the users of your Web site are using might not be able to present images. For instance, people with disabilities sometimes use assistive technologies that cannot interpret what an image represents. These assistive technologies use the alternative text of the image instead.
	</p>
	<p>
		An example of this could be a user that has a program that reads the content of the page out load. These kinds of programs cannot interpret what an image looks like, but they are good at finding and reading the alternative texts out loud.
	</p>
</div>

<div id="Section2" class="hidden">
	<h1>
		Links
	</h1>
	<h2>
		Phrase Clear Links
	</h2>
	<p>
		The basic rule is that a link should be understandable even when it is read out of the context. The link text should be able to stand on its own. This means that a link text should make clear what is going to happen if you choose to click the link. Imagine a situation where you can only see the link text. If so, would you understand where the link went? In this case, your link text is good enough. If not, you should add additional information to the link. Or rephrase the link.
	</p>
	<h2>
		Additional Link Descriptions
	</h2>
	<p>
		Sometimes, a link text isn't clear enough by itself. In this case you should add a ToolTip to the link.
	</p>
	<p>
		"Read more" is an example of a link that isn't clear enough by itself. Links like this should have an additional ToolTip. A "read more" link, linking to a text about banana import setting new records, could have the ToolTip "Read more about the banana import setting records".
	</p>
	<h3>	
		<a id="ShowHideLink21" title="<%= EPiServer.Global.EPLang.TranslateForScript("/edit/editorguide/showsection") %>"
		href="javascript:showOrHideSubSection('SubSection21', 'ShowHideImage21', 'ShowHideLink21')">
			<img id="ShowHideImage21" src="<%=EPiServer.Global.EPConfig.RootDir%>util/images/EditorGuide/arrowdown.gif" />Graphical Elements That Are Also Links
		</a>
	</h3>
	<div id="SubSection21" class="hidden">
		<p>
			If an image can be clicked, you should describe both the image and the link. According to what you have learned previously, the image should be described using an alternative text, and the link using a ToolTip. However, in order to be sure to make it work for a person using assistive technologies, you should use the same description for both the alternative text and the ToolTip.
		</p>
		<p>
			Here's a common example. In most cases, the organization's logotype is clickable and leads back to the start page. It's both an image and a link at the same time. The best way to make it work is to write the same for both the alternative text and the ToolTip, e.g. "Logotype of Company Inc, go to start page of Company Inc.". 
		</p>
	</div>
	<h3>	
		<a id="ShowHideLink22" title="<%= EPiServer.Global.EPLang.TranslateForScript("/edit/editorguide/showsection") %>"
		href="javascript:showOrHideSubSection('SubSection22', 'ShowHideImage22', 'ShowHideLink22')">
			<img id="ShowHideImage22" src="<%=EPiServer.Global.EPConfig.RootDir%>util/images/EditorGuide/arrowdown.gif" />Links Leading to Alternative Formats
		</a>
	</h3>
	<div id="SubSection22" class="hidden">
		<p>
			If the link you're creating leads to a document that is not a Web page (e.g. PDF, Word, PowerPoint, etc.), the file format should be specified in the link. The size of the file might also require specification, especially in the case of a large document.
		</p>
		<p>
			Note! Some Web sites might have been made in a way that file format and file size are automatically added to the link. If your Web site works this way, you don't have to add this information manually.
		</p>
	</div>
	<h3>	
		<a id="ShowHideLink23" title="<%= EPiServer.Global.EPLang.TranslateForScript("/edit/editorguide/showsection") %>"
		href="javascript:showOrHideSubSection('SubSection23', 'ShowHideImage23', 'ShowHideLink23')">
			<img id="ShowHideImage23" src="<%=EPiServer.Global.EPConfig.RootDir%>util/images/EditorGuide/arrowdown.gif" />Links Opening Internal Pages in a New Window
		</a>
	</h3>
	<div id="SubSection23" class="hidden">
		<p>
			The user should be informed that the page will open in a new window. This can be done in three ways:
		</p>
		<ul>
			<li>
				Write it clearly in the link			
			</li>
			<li>
				Write it in the ToolTip
			</li>
			<li>
				Use an icon announcing new window
			</li>
		</ul>
		<p>
			In general, new windows should be used sparingly, only when it's well motivated.
		</p>
	</div>
	<h3>	
		<a id="ShowHideLink24" title="<%= EPiServer.Global.EPLang.TranslateForScript("/edit/editorguide/showsection") %>"
		href="javascript:showOrHideSubSection('SubSection24', 'ShowHideImage24', 'ShowHideLink24')">
			<img id="ShowHideImage24" src="<%=EPiServer.Global.EPConfig.RootDir%>util/images/EditorGuide/arrowdown.gif" />Links Opening External Web Sites in a New Window
		</a>
	</h3>
	<div id="SubSection24" class="hidden">
		<p>
			The user should be informed that
		</p>
		<ul>
			<li>
				the link leads to another Web site			
			</li>
			<li>
				the link will open in a new window
			</li>
		</ul>		
		<p>
			This can be done in three ways:
		</p>
		<ul>
			<li>
				Write it clearly in the link			
			</li>
			<li>
				Write it in the ToolTip
			</li>
			<li>
				Use an icon announcing external Web site and new window
			</li>
		</ul>
	</div>
	<h2>
		Why Is This Important?
	</h2>
	<p>
		Links are among the most important things on a Web site. A user that doesn't understand your links will end up in the wrong places and spend longer than necessary looking. By having clear links and by helping the user distinguish between different kinds of links, your Web site will be easier to use. Some users depend on assistive technologies that read all links apart, like a long list. Therefore, the link has to be clear by itself.
	</p>
</div>

<div id="Section3" class="hidden">
	<h1>
		Forms
	</h1>
	<p>
		Unlike pages that only contain information, forms are pages (or parts of pages) where the user does not only have to read the page, but also has to fill in certain information. Usually, such parts of the Web site are said to be interactive. This means that the user is supposed to be active, and this makes clarity and logic important so that the user understands how to fill in the form.
	</p>
	<p>
		In order to make it easier for users to understand how to use a form, the form should be consistently and clearly designed. It is essential that all headings and input fields of the form are placed in a logical and consistent way. Headings should, whenever possible, be placed in front of the input field. Extensive and complex forms might require dividing them into clear sections.
	</p>
	<h2>
		Technical Guidelines
	</h2>
	<p>
		If you are not used to creating forms, you might need help from someone who is familiar with how the technical design should be made. For complex forms, there are technical regulations that are quite extensive.
	</p>
	<p>
		For simple forms, and as a minimum for making forms accessible, you should consider the following:
	</p>
	<ol>
		<li>
			Connect headings and input fields instead of using a separate heading for the field.
		</li>
		<li>
			Explain form fields using ToolTips if the heading of the fields doesn't give a sufficient explanation.
		</li>
	</ol>
	<h2>
		Why Is This Important?
	</h2>
	<p>
		Forms involve an interactive element for the user. This raises the requirements for clarity and comprehension. If the user depends on different kinds of assistive technologies when filling in the form, the form has to be elaborated according to certain technical guidelines. If not, understanding how to fill in the form might be impossible.
	</p>
</div>

<div id="Section4" class="hidden">
	<h1>
		Tables
	</h1>
	<p>
		When presenting information in the form of tables, it's important to try to clarify the table through the visual presentation. Hence, row and column headings should graphically differ from the content of the table itself. If there are many rows or columns, they might need to be separated using colors, backgrounds, etc.
	</p>
	<p>
		If the table contains complex information, it might be good to add the same information in the form of a diagram.
	</p>
	<h2>
		Don't Use Tables for Layout
	</h2>
	<p>
		Don't create layout using tables. Doing so makes the pages inaccessible. For a user depending on an assistive technology that reads the pages out loud, it might be impossible or very difficult to make the reading work. The assistive technology tries to interpret the information as table data (data arranged in columns), while you have used tables to control the design of the page. Due to this, the assistive technology might miss the information entirely, or it might read the information in an entirely wrong order. Therefore, tables should only be used for data arranged in columns.
	</p>
	<h2>
		Technical Guidelines
	</h2>
	<p>
		If you are not used to creating tables, you might need help from someone who is familiar with how the technical design should be made. For complex tables, there are technical regulations that are quite extensive.
	</p>
	<p>
		For simple tables, and as a minimum for making tables accessible, you should consider the following:
	</p>
	<ol>
		<li>
			Specify which table cells that are heading cells.
		</li>
		<li>
			In the case of data tables that have more than one logical level, table headings should be associated with table cells.
		</li>
	</ol>
	<p>
		There is a description of how this is done in EPiServer in the Editor's Manual.
	</p>
	<h2>
		Why Is This Important?
	</h2>
	<p>
		Many people find tables difficult to understand. Therefore, it's important to make the presentation as clear as possible. Users depending on different kinds of assistive technologies need the table to be designed in a technically correct way. Otherwise, they cannot get any sensible information from the table.
	</p>
</div>

<div id="Section5" class="hidden">
	<h1>
		Text
	</h1>
	<h2>
		Typographic Advice
	</h2>
	<p>
		It is important for users to quickly be able to find their way around a page and new text material. To help the user in doing so, it's important to use a clear and consistent typography. Menus and links should be easy to distinguish from headings and normal text. It should also be easy to distinguish between different kinds of links.
	</p>
	<p>
		The text sections should have a text size large enough for most readers to be able to read the screen without any problems. The rows shouldn't be too long or too close. Most of this is taken care of by the template pages and style sheets used for your Web site. So normally, these are not issues most editors have to think about.
	</p>
	<h2>
		Headings
	</h2>
	<p>
		Use headings to structure the pages in a clear way. A main heading might be enough for shorter texts. However, more extensive texts might need both main headings and subheadings. Keep in mind that headings and subheadings create a hierarchy in the text.
	</p>
	<p>
		In order to use a subheading, there must be a main heading. To make it look good, sometimes you might need different kinds of main headings. Main headings of different sizes, for instance. It is important that the headings you need are available as heading classes. Avoid creating your own headings – they will not be accessible as headings to users depending on assistive technologies.
	</p>
	<p>
		Clear and well-phrased headings make your pages easier to read. This is especially important for people with disabilities. The reader will also find it easier to quickly get an idea of the text. Your search engine may also find it easier to index pages in a good way if there are headings.
	</p>
	<p>
		It is not enough for a heading to look like a heading for it to be interpreted as one by a read-out-loud assistive technology. What the eye sees as a heading, having larger text size, bold font, etc., is not enough for an assistive technology. The assistive technologies require a heading code. This code is called H, which stands for Heading. If there are no such "H elements" in the code of your Web site, some users cannot distinguish between headings and normal text. This makes these users lose the structure created by your headings.
	</p>
	<h2>
		Text Sections
	</h2>
	<p>
		Longer texts should be clearly divided into short paragraphs. Paragraph spaces are preferable to indentations. Use headings along with introductions to facilitate the reading of long texts.
	</p>
	<p>
		Reading a text can be made easier for readers with reading difficulties (20-30% of the adult population) by structuring it well. The templates and style sheets of the Web site can determine the presentation, but they might sometimes require adjustment in order for readability to improve. As an editor, you can avoid writing long paragraphs and you can use headings and subheadings to help the reader through the text.
	</p>
	<p>
		Pages are often easier to read if there are images that help the texts to provide the information. This helps most users, especially the ones with reading difficulties. All images shall, of course, be described using an alternative text.
	</p>
	<h3>	
		<a id="ShowHideLink51" title="<%= EPiServer.Global.EPLang.TranslateForScript("/edit/editorguide/showsection") %>"
		href="javascript:showOrHideSubSection('SubSection51', 'ShowHideImage51', 'ShowHideLink51')">
			<img id="ShowHideImage51" src="<%=EPiServer.Global.EPConfig.RootDir%>util/images/EditorGuide/arrowdown.gif" />Bulleted and Numbered Lists
		</a>
	</h3>
	<div id="SubSection51" class="hidden">
		<p>
			Lists are good for lining up information. Use the list function in the Editor to create correct lists.
		</p>
		<p>
			Don't use lists to create layout. Don't make your own list design by using image elements and texts in a table structure.
		</p>
		<p>
			If you don't like the look of the lists created in the Editor, it can be changed in the style sheets that specify how different kinds of text is to be presented.
		</p>
		<p>
			Technically, a list is not created using ordinary lines or dots and line breaks. In this case, a user that is using an assistive technology will not understand that it is a list, which will make the information hard to understand.
		</p>
	</div>
	<h2>
		Writing Tips
	</h2>
	<p>
		There is a great amount of literature on this subject, in case you want to read more about how to write good Web texts. Your organization may also have its own writing rules. Basic advice on how to make your text easier to read can be found here.
	</p>
	<h3>	
		<a id="ShowHideLink52" title="<%= EPiServer.Global.EPLang.TranslateForScript("/edit/editorguide/showsection") %>"
		href="javascript:showOrHideSubSection('SubSection52', 'ShowHideImage52', 'ShowHideLink52')">
			<img id="ShowHideImage52" src="<%=EPiServer.Global.EPConfig.RootDir%>util/images/EditorGuide/arrowdown.gif" />Write as Simply as Possible
		</a>
	</h3>
	<div id="SubSection52" class="hidden">
		<p>
			Try to phrase the content as simply and clearly as possible, and consider that many different groups of users might need to read and understand the same texts. Sometimes, the same information may be required in several different versions. This advice doesn't mean you should avoid writing about difficult or complex things. However, it does mean that you should keep in mind how to express yourself in order for your readers to understand what you are writing about.
		</p>
	</div>
	<h3>	
		<a id="ShowHideLink53" title="<%= EPiServer.Global.EPLang.TranslateForScript("/edit/editorguide/showsection") %>"
		href="javascript:showOrHideSubSection('SubSection53', 'ShowHideImage53', 'ShowHideLink53')">
			<img id="ShowHideImage53" src="<%=EPiServer.Global.EPConfig.RootDir%>util/images/EditorGuide/arrowdown.gif" />Write the Most Important First
		</a>
	</h3>
	<div id="SubSection53" class="hidden">
		<p>
			There are several reasons for structuring the material so that the most important part is at the beginning of the document. It helps the user to quickly decide if he or she should continue reading the document in question, or look through other documents.
		</p>
		<p>
			Many users don't read all of the text in a document. For instance, it is common for a user not to scroll down a document, but only read the text that is visible on the screen. Other users might get tired or pressured while reading or they might not be able to maintain their concentration. Unfamiliar readers often find long texts problematic.
		</p>
	</div>
	<h3>	
		<a id="ShowHideLink54" title="<%= EPiServer.Global.EPLang.TranslateForScript("/edit/editorguide/showsection") %>"
		href="javascript:showOrHideSubSection('SubSection54', 'ShowHideImage54', 'ShowHideLink54')">
			<img id="ShowHideImage54" src="<%=EPiServer.Global.EPConfig.RootDir%>util/images/EditorGuide/arrowdown.gif" />Explain Difficult and Unusual Terms
		</a>
	</h3>
	<div id="SubSection54" class="hidden">
		<p>
			Words and terms that are obvious to you and your organization might be difficult for someone that isn't familiar with the subject to understand. For this reason, you should try to find a good way of explaining difficult words and unusual terms.
		</p>
		<p>
			If there are simpler words with the same meaning as a more difficult one, you should use the simpler word.
		</p>
	</div>
	<h3>	
		<a id="ShowHideLink55" title="<%= EPiServer.Global.EPLang.TranslateForScript("/edit/editorguide/showsection") %>"
		href="javascript:showOrHideSubSection('SubSection55', 'ShowHideImage55', 'ShowHideLink55')">
			<img id="ShowHideImage55" src="<%=EPiServer.Global.EPConfig.RootDir%>util/images/EditorGuide/arrowdown.gif" />Preferably Spell Out Abbreviations and Acronyms
		</a>
	</h3>
	<div id="SubSection55" class="hidden">
		<p>
			Abbreviations and acronyms can cause problems. An acronym is an abbreviation that can be read like a real word, and you can't count on the user understanding an abbreviation. Therefore, you should generally avoid abbreviations.
		</p>
		<p>
			The abbreviations used may require explaining. There are several ways to do this. Either you spell out the abbreviation in plain language. You should at least do this the first time an abbreviation occurs in a text. Another considerable option is to explain abbreviations (and other important or difficult terms) in a glossary.
		</p>
	</div>
	<h3>	
		<a id="ShowHideLink56" title="<%= EPiServer.Global.EPLang.TranslateForScript("/edit/editorguide/showsection") %>"
		href="javascript:showOrHideSubSection('SubSection56', 'ShowHideImage56', 'ShowHideLink56')">
			<img id="ShowHideImage56" src="<%=EPiServer.Global.EPConfig.RootDir%>util/images/EditorGuide/arrowdown.gif" />Date Format
		</a>
	</h3>
	<div id="SubSection56" class="hidden">
		<p>
			Read-out-loud programs might have difficulties handling dates. All users may have problems understanding dates if they are presented differently in different parts of the Web site. Therefore, all dates should be written the same way. This goes for both the dates that are created automatically in different listings or written out in the templates, and the ones created manually by the editors. This gives the user a better chance of understanding and handling dates. The recommended way of writing dates is: year-month-day.
		</p>
		<p>
			For instance, this sentence was written 2005-07-08, which is the recommended way of writing dates.
		</p>
	</div>
	<h2>
		Easy-to-Read Versions and Sign Language
	</h2>
	<p>
		For some users, making the regular Web site as good as possible isn't enough. These users are in need of additional information, adapted to their special conditions.
	</p>
	<h3>	
		<a id="ShowHideLink57" title="<%= EPiServer.Global.EPLang.TranslateForScript("/edit/editorguide/showsection") %>"
		href="javascript:showOrHideSubSection('SubSection57', 'ShowHideImage57', 'ShowHideLink57')">
			<img id="ShowHideImage57" src="<%=EPiServer.Global.EPConfig.RootDir%>util/images/EditorGuide/arrowdown.gif" />Easy-to-Read
		</a>
	</h3>
	<div id="SubSection57" class="hidden">
		<p>
			There is a way of writing called "Easy-to-Read" for people with mental disabilities and for people that don't have a good command of the language in question. Using this way of writing, the text can be simplified in order for it to be easier to understand. There are special training programs available for learning this way of writing.
		</p>
		<p>
			Here is an example (Source: The Centre for Easy-to-Read, <a href="http://www.lattlast.se" target="_blank">www.lattlast.se</a>):
		</p>
		<p>
			Text before:
			<br />
			"When you leave your country, you get a whole new situation of life. You leave a familiar context and a common language. You lose the life where you felt your identity and safety. You don't understand the language, the interplay and the codes of the new country."
		</p>
		<p>
			Text after:
			<br />
			"It's hard to move to another country. You can't talk to the people there. You don't know how they greet or thank each other."
		</p>
	</div>
	<h3>	
		<a id="ShowHideLink58" title="<%= EPiServer.Global.EPLang.TranslateForScript("/edit/editorguide/showsection") %>"
		href="javascript:showOrHideSubSection('SubSection58', 'ShowHideImage58', 'ShowHideLink58')">
			<img id="ShowHideImage58" src="<%=EPiServer.Global.EPConfig.RootDir%>util/images/EditorGuide/arrowdown.gif" />Sign Language
		</a>
	</h3>
	<div id="SubSection58" class="hidden">
		<p>
			It can be important for deaf people to get certain information in their own language – sign language. Material like this is placed on the Web site in the form of films. Many deaf people find it easier to understand information given in sign language, compared to information in writing. That's why additional sign-language information might be needed in addition to text.
		</p>
	</div>
</div>

<div id="Section6" class="hidden">
	<h1>
		Colors and Contrasts
	</h1>
	<h2>
		The User's Color Perception Ability
	</h2>
	<p>
		If you rely on color alone to provide information, users with color perception deficiency will not be able to access the information in the way it was planned. An example is when you give a certain text a red color in order to indicate something important. If colors are used to provide information, it's very important that this information is also provided in some other way. For the example above, red color along with a bold font is, therefore, better than only red color.
	</p>
	<p>
		To be certain that pages work even if the user cannot perceive the color, you can test the page by looking at it in a black-and-white monitor, or by printing it on a black-and-white printer.
	</p>
	<h2>
		Contrasts
	</h2>
	<p>
		When the color range and luminance of the foreground and background colors are too close, some users will have readability problems. Choose colors that give high contrast and thereby better readability for everyone. Reading speed and the possibility of reading from a distance are closely connected to contrasts. Examples of high contrasts are: black text on white background, green on white, blue on white and black on yellow.
	</p>
	<p>
		Only use foreground and background colors that together give enough contrast effect.
	</p>
	<p>
		A good way of testing if the differences between colors are sufficient is to measure the luminance difference between the two colors. The difference between the colors should be at least 50 units on a 100 degree scale. If you have access to Adobe Photoshop, you can measure the color-value difference as explained.
	</p>
	<h2>
		Why Is This Important?
	</h2>
	<p>
		Not everyone perceives color the same way. Certain equipment reproduces color in an incorrect way, and many people find it hard to read a text where the contrast is too low.
	</p>
</div>
