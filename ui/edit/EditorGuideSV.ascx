<%@ Control Language="c#" AutoEventWireup="false" Codebehind="EditorGuideSV.ascx.cs" Inherits="EPiServer.Edit.EditorGuideSV" TargetSchema="http://schemas.microsoft.com/intellisense/ie5" %>
<%@ Register TagPrefix="EPiServer" Namespace="EPiServer.WebControls" Assembly="EPiServer" %>

<h1>
	Användbarhetsguide
</h1>
<p>
	Här kan du läsa om hur du som redaktör kan skapa användbart och tillgängligt innehåll anpassat för webben.
</p>
<p>
	<a href="javascript:displaySection('Section1')" class="EPEdit-editorGuideNavigationHeader"><img src="<%=EPiServer.Global.EPConfig.RootDir%>util/images/EditorGuide/arrowright.gif" />Bilder och grafiska element</a>
	<br />
	<a href="javascript:displaySection('Section2')" class="EPEdit-editorGuideNavigationHeader"><img src="<%=EPiServer.Global.EPConfig.RootDir%>util/images/EditorGuide/arrowright.gif" />Länkar</a>
	<br />
	<a href="javascript:displaySection('Section3')" class="EPEdit-editorGuideNavigationHeader"><img src="<%=EPiServer.Global.EPConfig.RootDir%>util/images/EditorGuide/arrowright.gif" />Formulär</a>
	<br />
	<a href="javascript:displaySection('Section4')" class="EPEdit-editorGuideNavigationHeader"><img src="<%=EPiServer.Global.EPConfig.RootDir%>util/images/EditorGuide/arrowright.gif" />Tabeller</a>
	<br />
	<a href="javascript:displaySection('Section5')" class="EPEdit-editorGuideNavigationHeader"><img src="<%=EPiServer.Global.EPConfig.RootDir%>util/images/EditorGuide/arrowright.gif" />Text</a>
	<br />
	<a href="javascript:displaySection('Section6')" class="EPEdit-editorGuideNavigationHeader"><img src="<%=EPiServer.Global.EPConfig.RootDir%>util/images/EditorGuide/arrowright.gif" />Färger och kontraster</a>
</p>
<hr />
<div id="DisplayText">
	<p>
		Klicka på någon av rubrikerna ovan för att läsa om respektive område.
	</p>
</div>

<div id="Section1" class="hidden">
	<h1>
		Bilder och grafiska element
	</h1>
	<h2>
		Komplettera bilder och andra grafiska element med alternativ text
	</h2>
	<p>
		Grafiska element – fotografier, illustrationer, kartor, text som sparats som bild etc. ska kompletteras med en kort alternativ beskrivning. Detta kallas alternativ text. Om du vill kontrollera hur de alternativa texterna blir på din webbplats så syns de som gula rutor om du pekar på bilderna (om du använder Internet Explorer som webbläsare).
	</p>
	<p>
		Den alternativa texten ska beskriva bilden och bildens funktion. Det betyder att olika typer av bilder kan behöva mer eller mindre omfattande beskrivningar. Se nedan vad som gäller för några olika typer av grafiska element.
	</p>
	<p>
		Observera att samma bild kan behöva beskrivas på olika sätt beroende på i viket sammanhang den publiceras. Undvik därför att arbeta med fasta alternativa bildbeskrivningar.
	</p>
	<h3>	
		<a id="ShowHideLink11" title="<%= EPiServer.Global.EPLang.TranslateForScript("/edit/editorguide/showsection") %>"
		href="javascript:showOrHideSubSection('SubSection11', 'ShowHideImage11', 'ShowHideLink11')">
			<img id="ShowHideImage11" src="<%=EPiServer.Global.EPConfig.RootDir%>util/images/EditorGuide/arrowdown.gif" />Bilder av dekorkaraktär
		</a>
	</h3>
	<div id="SubSection11" class="hidden">
		<p>
			Bilder som mest används för att lätta upp sidan har ingen djupare funktion och ska därför beskrivas kortfattat. OBS! Du behöver inte skriva "Bild". Däremot kan det vara bra att skriva om bilden är ett fotografi eller en illustration. Den alternativa texten: "Glada barn som leker i sandlådan. Fotografi" är en bra alternativ text för en bild som används på en sida för att lätta upp en text om förskoleverksamhet.
		</p>
	</div>
	<h3>	
		<a id="ShowHideLink12" title="<%= EPiServer.Global.EPLang.TranslateForScript("/edit/editorguide/showsection") %>"
		href="javascript:showOrHideSubSection('SubSection12', 'ShowHideImage12', 'ShowHideLink12')">
			<img id="ShowHideImage12" src="<%=EPiServer.Global.EPConfig.RootDir%>util/images/EditorGuide/arrowdown.gif" />Innehållsrika bildelement
		</a>
	</h3>
	<div id="SubSection12" class="hidden">
		<p>
			Vissa bilder innehåller information som är mycket viktig för användarens förståelse. Det kan till exempel vara diagram, ritningar, sprängskisser eller nyhetsbilder. För dessa krävs en mer noggrann och omfattande beskrivning. Försök ändå att begränsa beskrivningen till max 150 tecken.
		</p>
		<p>
			Behöver bilden förklaras mer än så kan du behöva beskriva bilden i en separat text. Ibland finns en sådan beskrivning i den text som omger bilden. Då kan den alternativa texten referera till denna text.
		</p>
	</div>
	<h3>	
		<a id="ShowHideLink13" title="<%= EPiServer.Global.EPLang.TranslateForScript("/edit/editorguide/showsection") %>"
		href="javascript:showOrHideSubSection('SubSection13', 'ShowHideImage13', 'ShowHideLink13')">
			<img id="ShowHideImage13" src="<%=EPiServer.Global.EPConfig.RootDir%>util/images/EditorGuide/arrowdown.gif" />Bildkartor (image maps)
		</a>
	</h3>
	<div id="SubSection13" class="hidden">
		<p>
			En bildkarta är en bild där delar av bilden är klickbara med länkar till andra sidor. Elementen,  de olika delarna av bildkartan, består då både av bilder och länkar samtidigt. För att en bildkarta ska fungera ska bilden vara beskriven med en alternativ text. Varje länk ska dessutom vara beskriven med en kompletterande text, en så kallad länktitel. Dessutom kan det vara bra om du har vanliga textlänkar bredvid bildelementet. 
		</p>
		<p>
			Om du tänker dig en länskarta där varje kommun ska vara klickbar så beskriver du länskartan med hjälp av alternativ text och länken till varje kommun med en länktitel.
		</p>
	</div>
	<h3>	
		<a id="ShowHideLink14" title="<%= EPiServer.Global.EPLang.TranslateForScript("/edit/editorguide/showsection") %>"
		href="javascript:showOrHideSubSection('SubSection14', 'ShowHideImage14', 'ShowHideLink14')">
			<img id="ShowHideImage14" src="<%=EPiServer.Global.EPConfig.RootDir%>util/images/EditorGuide/arrowdown.gif" />Ikoner
		</a>
	</h3>
	<div id="SubSection14" class="hidden">
		<p>
			Ikoner används för att markera vissa speciella funktioner och ska tydliggöra den aktuella funktionen. Ikoner bör användas sparsamt och använd standardikoner så långt det är möjligt. Undvik ikoner i löpande text.
		</p>
		<p>
			Ikoner ska beskrivas med alternativ text. Om ikonen är klickbar ska den både beskrivas med alternativ text och med en länktitel.
		</p>
	</div>
	<h3>	
		<a id="ShowHideLink15" title="<%= EPiServer.Global.EPLang.TranslateForScript("/edit/editorguide/showsection") %>"
		href="javascript:showOrHideSubSection('SubSection15', 'ShowHideImage15', 'ShowHideLink15')">
			<img id="ShowHideImage15" src="<%=EPiServer.Global.EPConfig.RootDir%>util/images/EditorGuide/arrowdown.gif" />Textbilder
		</a>
	</h3>
	<div id="SubSection15" class="hidden">
		<p>
			Undvik att använda bilder för att endast presentera text. I de flesta fall går det att ersätta "textbilder" med riktig text. I vissa fall kan det krävas en utveckling av er webbplats så kallade stilmall (CSS) för att det ska fungera.
		</p>
		<p>
			Om du ändå använder textbilder så måste du skriva in samma text som en alternativ text.
		</p>
	</div>
	<h2>
		Icke meningsbärande grafiska element
	</h2>
	<p>
		Om bildens funktion inte är meningsbärande ska du inte ange någon alternativ text. Exempel på icke meningsbärande element är typografiska linjer, prickar och liknande, som används för att tydliggöra den visuella presentationen på sidan.
	</p>
	<h2>
		Varför är det här viktigt?
	</h2>
	<p>
		Det är inte säkert att den utrustning som användarna av din webbplats använder kan presentera bilder. Till exempel har personer med funktionshinder ibland hjälpmedel som inte kan tolka vad en bild föreställer. Istället använder dessa hjälpmedel bildens alternativa text. 
	</p>
	<p>
		Ett sådant exempel är att användaren kan ha ett program som läser upp innehållet på sidan. Sådana program kan inte tolka vad som finns i en bild men de är bra på att hitta och läsa upp de alternativa texterna.
	</p>
</div>

<div id="Section2" class="hidden">
	<h1>
		Länkar
	</h1>
	<h2>
		Formulera tydliga länkar
	</h2>
	<p>
		Grundregeln är att en länk ska kunna förstås även om länken läses utlyft ur det sammanhang där den presenteras. Länktexten ska så att säga kunna stå på egna ben. Det betyder att en länktext ska tydliggöra vad som kommer att hända om man väljer att klicka på länken. Tänk dig in i en situation där du bara ser länktexten. Skulle du förstå vart länken då leder? I så fall har du en tillräckligt bra länktext. Om inte, då måste du komplettera länken med ytterligare information. Eller skriva om länken.
	</p>
	<h2>
		Kompletterande beskrivningar av länkar
	</h2>
	<p>
		Ibland blir en länk inte tillräckligt tydlig i sig själv. Då ska du komplettera länktexten med en så kallad länktitel.
	</p>
	<p>
		"Läs mer" är ett exempel på en länk som inte är tydlig i sig själv. Sådana länkar ska kompletteras med en länktitel En "läs mer"-länk som leder till en text om att importen av bananer slår nya rekord kan då ha länktiteln "Läs mer om att importen av bananer slår rekord".
	</p>
	<h3>	
		<a id="ShowHideLink21" title="<%= EPiServer.Global.EPLang.TranslateForScript("/edit/editorguide/showsection") %>"
		href="javascript:showOrHideSubSection('SubSection21', 'ShowHideImage21', 'ShowHideLink21')">
			<img id="ShowHideImage21" src="<%=EPiServer.Global.EPConfig.RootDir%>util/images/EditorGuide/arrowdown.gif" />Bildelement som även är länkar
		</a>
	</h3>
	<div id="SubSection21" class="hidden">
		<p>
			Om en bild är klickbar ska du beskriva både bilden och länken. Enligt det du lärt dig ovan ska bilden beskrivas med en alternativ text och länken med en länktitel. För att vara helt säker på att det ska fungera för en person med hjälpmedel bör du dock använda samma beskrivning för både alternativ text och länktitel. 
		</p>
		<p>
			För att ta ett vanligt exempel. Oftast är verksamhetens logotyp klickbar och leder tillbaka till startsidan. Den är både en bild och en länk samtidigt. Då fungerar det bäst om du skriver till exempel: "Logotyp för Bolaget AB, till startsidan för Bolaget AB" både som alternativ text och som länktitel.
		</p>
	</div>
	<h3>	
		<a id="ShowHideLink22" title="<%= EPiServer.Global.EPLang.TranslateForScript("/edit/editorguide/showsection") %>"
		href="javascript:showOrHideSubSection('SubSection22', 'ShowHideImage22', 'ShowHideLink22')">
			<img id="ShowHideImage22" src="<%=EPiServer.Global.EPConfig.RootDir%>util/images/EditorGuide/arrowdown.gif" />Länkar som leder till alternativa format
		</a>
	</h3>
	<div id="SubSection22" class="hidden">
		<p>
			Om den länk du skapar leder till dokument som inte är webbsidor (till exempel PDF, Word, PowerPoint etc.) så ska du ange filformatet i länken. Även filens storlek kan behöva anges, särskilt om det är fråga om ett stort dokument. 
		</p>
		<p>
			OBS! Vissa webbplatser är gjorda så att filformat och filstorlek automatiskt tillfogas länken. Om din webbplats fungerar på det sättet behöver du inte ange dessa uppgifter manuellt.
		</p>
	</div>
	<h3>	
		<a id="ShowHideLink23" title="<%= EPiServer.Global.EPLang.TranslateForScript("/edit/editorguide/showsection") %>"
		href="javascript:showOrHideSubSection('SubSection23', 'ShowHideImage23', 'ShowHideLink23')">
			<img id="ShowHideImage23" src="<%=EPiServer.Global.EPConfig.RootDir%>util/images/EditorGuide/arrowdown.gif" />Länkar som öppnar interna sidor i nytt fönster
		</a>
	</h3>
	<div id="SubSection23" class="hidden">
		<p>
			Användaren ska förvarnas om att sidan öppnas i nytt fönster. Du kan göra det på tre sätt:
		</p>
		<ul>
			<li>
				Skriv det i klartext i länken			
			</li>
			<li>
				Skriv det i länktiteln
			</li>
			<li>
				Använd en ikon som signalerar nytt fönster
			</li>
		</ul>
		<p>
			Generellt gäller att du bör använda nya fönster sparsamt och när det är väl motiverat.		
		</p>
	</div>
	<h3>	
		<a id="ShowHideLink24" title="<%= EPiServer.Global.EPLang.TranslateForScript("/edit/editorguide/showsection") %>"
		href="javascript:showOrHideSubSection('SubSection24', 'ShowHideImage24', 'ShowHideLink24')">
			<img id="ShowHideImage24" src="<%=EPiServer.Global.EPConfig.RootDir%>util/images/EditorGuide/arrowdown.gif" />Länkar som öppnar externa webbplatser i nytt fönster
		</a>
	</h3>
	<div id="SubSection24" class="hidden">
		<p>
			Användaren ska förvarnas om
		</p>
		<ul>
			<li>
				att länken leder till en annan webbplats			
			</li>
			<li>
				att länken öppnas i ett nytt fönster
			</li>
		</ul>		
		<p>
			Du kan göra det på tre sätt:
		</p>
		<ul>
			<li>
				Skriv det i klartext i länken			
			</li>
			<li>
				Skriv det i länktiteln
			</li>
			<li>
				Använd en ikon som signalerar extern webbplats och nytt fönster
			</li>
		</ul>
	</div>
	<h2>
		Varför är det här viktigt?
	</h2>
	<p>
		Länkar är bland det viktigaste som finns på en webbplats. En användare som inte förstår dina länkar kommer att hamna fel eller får leta onödigt länge. Genom att ha tydliga länkar och genom att hjälpa användaren att förstå skillnader mellan olika typer av länkar så blir det enklare att använda din webbplats. Vissa användare har hjälpmedel som läser alla länkar för sig, som i en lång lista. Därför måste länken vara tydlig i sig själv.
	</p>
</div>

<div id="Section3" class="hidden">
	<h1>
		Formulär
	</h1>
	<p>
		Till skillnad från sidor som enbart innehåller information så är formulär sidor (eller delar av sidor) där användaren inte bara ska läsa på sidan utan också själv fylla i vissa uppgifter. Man brukar säga att sådana delar av webbplatsen är interaktiva. Det betyder att användaren ska vara aktiv och då är det viktigt att vara tydlig och logisk så att användaren förstår hur formuläret ska fyllas i . 
	</p>
	<p>
		För att användarna lättare ska förstå hur de ska använda ett formulär krävs att formuläret har en konsekvent och tydlig utformning. Grundläggande är att ledtexter och inmatningsfält i formulär ska vara placerade på ett logiskt och konsekvent sätt. Ledtexter bör så långt som möjligt vara placerade före inmatningsfältet. Omfattande och komplexa formulär kan behöva delas upp i tydliga avdelningar.
	</p>
	<h2>
		Tekniska riktlinjer
	</h2>
	<p>
		Om du är ovan vid att skapa formulär så kan du behöva ta hjälp av någon som satt sig in i hur den tekniska konstruktionen ska gå till. För komplexa formulär finns det ett tekniskt regelverk som är relativt omfattande.
	</p>
	<p>
		För enkla formulär och som ett minimum för att göra formulär tillgängliga gäller att:
	</p>
	<ol>
		<li>
			Koppla ihop ledtexter och inmatningsfält istället för att använda en separat ledtext för fältet.
		</li>
		<li>
			Förklara formulärfält med hjälp av skärmtips om inte fältets ledtext ger en tillräcklig förklaring.
		</li>
	</ol>
	<h2>
		Varför är det här viktigt?
	</h2>
	<p>
		Formulär innebär ett interaktivt moment för användaren. Det ställer stora krav på tydlighet och begriplighet. Om användaren har olika hjälpmedel för att fylla i formuläret måste det vara gjort enligt vissa tekniska riktlinjer. Annars kan det bli omöjligt att förstå hur formuläret ska fyllas i.
	</p>
</div>

<div id="Section4" class="hidden">
	<h1>
		Tabeller
	</h1>
	<p>
		När information presenteras i tabellform är det viktigt att försöka förtydliga tabellen genom den visuella presentationen. Rad- och kolumnrubriker bör därför grafiskt avvika från själva innehållet i tabellen. Om det är många rader eller kolumner kan dessa behöva separeras med hjälp av färger eller tonplattor etc.
	</p>
	<p>
		Om tabellen innehåller komplex information kan det vara bra att komplettera med samma information i diagramform. 
	</p>
	<h2>
		Använd inte layouttabeller
	</h2>
	<p>
		Skapa inte layout med hjälp av tabeller. Det ger otillgängliga sidor. För en användare med ett hjälpmedel som läser upp sidorna kan det vara omöjligt eller mycket svårt att få uppläsningen att fungera. Hjälpmedlet försöker tolka informationen som tabelldata (data uppställd i spalter och kolumner) medan du har styrt utformningen av sidan med hjälp av tabeller. Hjälpmedlet kan därför missa information helt eller läsa upp information i helt fel ordning. Tabeller ska därför bara användas för data uppställd i spalter och kolumner.
	</p>
	<h2>
		Tekniska riktlinjer
	</h2>
	<p>
		Om du är ovan vid att skapa tabeller så kan du behöva ta hjälp av någon som satt sig in i hur den tekniska konstruktionen ska gå till. För komplexa tabeller finns det ett tekniskt regelverk som är relativt omfattande.
	</p>
	<p>
		För enkla tabeller och som ett minimum för att göra tabeller tillgängliga gäller att:
	</p>
	<ol>
		<li>
			Ange vilka tabellceller som är rubrikceller.
		</li>
		<li>
			I datatabeller med mer än en logisk nivå ska tabellrubriker associeras med tabellceller.
		</li>
	</ol>
	<p>
		Hur du gör detta i EPiServer finns beskrivet i Redaktörshandboken.
	</p>
	<h2>
		Varför är det här viktigt?
	</h2>
	<p>
		Många tycker att tabeller är svåra att förstå. Det gäller att vara så tydlig i presentationen som möjligt. För de användare som har olika hjälpmedel gäller att de är beroende av att tabellen är konstruerad på ett tekniskt korrekt sätt. Annars kan de inte få ut någon vettig information ur tabellen.
	</p>
</div>

<div id="Section5" class="hidden">
	<h1>
		Text
	</h1>
	<h2>
		Typografiska råd
	</h2>
	<p>
		För en användare är det viktigt att snabbt kunna orientera sig på en sida och i ett textmaterial. För att hjälpa användaren är det viktigt att använda en tydlig och konsekvent typografi. Det ska vara lätt att skilja menyer och länkar från rubriker och löpande text. Det ska också vara lätt att skilja olika typer av länkar från varandra.
	</p>
	<p>
		Den löpande texten ska vara tillräckligt stor för att de flesta inte ska få problem med att läsa på skärmen. Raderna ska inte vara för långa eller ligga för tätt. Det mesta av detta sköts redan av de sidmallar och stilmallar som används på er webbplats, så det är normalt ingenting som du som redaktör behöver tänka på. 
	</p>
	<h2>
		Rubriker
	</h2>
	<p>
		Använd rubriker för att strukturera sidorna på ett tydligt sätt. För kortare texter kan det räcka med att texten har en huvudrubrik. Mer omfattande texter kan behöva både huvudrubriker och underrubriker. Tänk på att rubriker och underrubriker skapar en hierarki i texten. 
	</p>
	<p>
		För att kunna använda en underrubrik måste det finnas en huvudrubrik. För att det ska bli snyggt kan du ibland behöva olika typer av huvudrubriker, till exempel huvudrubriker med olika storlek. Det är viktigt att de rubriker du behöver finns som rubrikklasser. Undvik att skapa egna rubriker – de blir inte tillgängliga som rubriker för användare med hjälpmedel.
	</p>
	<p>
		Tydliga och bra formulerade rubriker gör dina sidor lättare att läsa. Det är särskilt viktigt för personer med lässvårigheter. Det blir också lättare för läsaren att snabbt bilda sig en uppfattning om texten. Dessutom kan din sökmotor ha lättare att indexera sidor på ett bra sätt om det finns rubriker.
	</p>
	<p>
		För att rubriker ska kunna tolkas som rubriker av ett uppläsande hjälpmedel så räcker det inte med att de ser ut som rubriker. Det ögat ser är en rubrik genom att storleken är större, stilen är fet etc. räcker inte för ett hjälpmedel. För hjälpmedlet måste det skapas en liten rubrikkod. Den kallas H, vilket betyder Heading. En huvudrubrik blir då H1 och en underrubrik H2. Om det inte blir sådana "H-taggar" i koden på din webbplats, så kan vissa användare inte skilja rubriker från löpande text. Och då tappar dessa användare den struktur som skapas av dina rubriker.
	</p>
	<h2>
		Löpande text
	</h2>
	<p>
		Längre texter bör indelas i korta och tydliga stycken. Styckemellanrum är att föredra framför indrag. Använd rubriker och gärna också ingresser för att underlätta läsning av långa texter
	</p>
	<p>
		Om läsaren har lässvårigheter (vilket 20-30% av den vuxna befolkningen har) så kan en välstrukturerad text underlätta läsningen. Webbplatsens mallar och stilmallar kan avgöra hur presentationen blir och de kan ibland behöva justeras så att läsbarheten blir bättre. Som redaktör kan du undvika att skriva långa stycken och du kan arbeta med rubriker och underrubriker för hjälpa läsaren igenom texten.
	</p>
	<p>
		Sidor blir ofta mer lättlästa om det finns bilder som hjälper texterna att förmedla informationen. Detta hjälper de flesta användare och speciellt användare med lässvårigheter. Självklart ska alla bilder beskrivas med hjälp av en alternativ text.
	</p>
	<h3>	
		<a id="ShowHideLink51" title="<%= EPiServer.Global.EPLang.TranslateForScript("/edit/editorguide/showsection") %>"
		href="javascript:showOrHideSubSection('SubSection51', 'ShowHideImage51', 'ShowHideLink51')">
			<img id="ShowHideImage51" src="<%=EPiServer.Global.EPConfig.RootDir%>util/images/EditorGuide/arrowdown.gif" />Punktlistor och numrerade listor
		</a>
	</h3>
	<div id="SubSection51" class="hidden">
		<p>
			Listor är bra när du radar upp information. Använd listfunktionen i editorn. Då skapas korrekta listor. 
		</p>
		<p>
			Använd inte listor för att skapa layout. Gör inte egna utseenden på listor genom att lägga bildelement och texter i en tabellstruktur. 
		</p>
		<p>
			Om du tycker att de listor du skapar via editorn inte ser bra ut så kan det ändras via de stilmallar som anger hur olika typer av text ska presenteras.
		</p>
		<p>
			Rent tekniskt blir det inga listor om du gör listor av vanliga streck eller punkter och radbrytningar. Då kan en användare med ett hjälpmedel inte förstå att det är en lista, vilket ofta gör informationen svårbegriplig. 
		</p>
	</div>
	<h2>
		Skrivtips
	</h2>
	<p>
		Det finns en omfattande litteratur på detta område för dig som vill fördjupa dig i hur man skriver bra webbtexter. Din organisation kan dessutom ha tagit fram egna skrivregler. Här presenteras några grundläggande råd, som gör din text lättare att ta till sig.
	</p>
	<h3>	
		<a id="ShowHideLink52" title="<%= EPiServer.Global.EPLang.TranslateForScript("/edit/editorguide/showsection") %>"
		href="javascript:showOrHideSubSection('SubSection52', 'ShowHideImage52', 'ShowHideLink52')">
			<img id="ShowHideImage52" src="<%=EPiServer.Global.EPConfig.RootDir%>util/images/EditorGuide/arrowdown.gif" />Skriv så enkelt som möjligt
		</a>
	</h3>
	<div id="SubSection52" class="hidden">
		<p>
			Försök att formulera innehållet så enkelt och tydligt som möjligt och tänk på att många olika grupper av användare kanske ska läsa och förstå samma texter. Ibland kan samma information behövas i flera olika versioner. Det här rådet betyder inte att du ska låta bli att skriva om sådant som är svårt eller komplext. Det betyder däremot att du hela tiden bör fundera på hur du ska formulera dig så att dina läsare förstår det du skriver om.
		</p>
	</div>
	<h3>	
		<a id="ShowHideLink53" title="<%= EPiServer.Global.EPLang.TranslateForScript("/edit/editorguide/showsection") %>"
		href="javascript:showOrHideSubSection('SubSection53', 'ShowHideImage53', 'ShowHideLink53')">
			<img id="ShowHideImage53" src="<%=EPiServer.Global.EPConfig.RootDir%>util/images/EditorGuide/arrowdown.gif" />Skriv det viktigaste först
		</a>
	</h3>
	<div id="SubSection53" class="hidden">
		<p>
			Av flera skäl är det därför viktigt att strukturera materialet så att det viktigaste finns först i dokumentet. Det hjälper användaren att snabbare kunna avgöra om han eller hon ska fortsätta läsa det aktuella dokumentet eller leta vidare i andra dokument. 
		</p>
		<p>
			Många användare läser inte hela texten i ett dokument. Det är t.ex. vanligt att användaren inte scrollar i ett dokument utan bara läser den text som ryms på skärmen. Andra användare kanske snabbt blir trötta eller ansträngda av läsningen eller de kanske inte har förmåga att behålla koncentrationen. Ovana läsare tycker ofta att långa texter känns problematiska.
		</p>
	</div>
	<h3>	
		<a id="ShowHideLink54" title="<%= EPiServer.Global.EPLang.TranslateForScript("/edit/editorguide/showsection") %>"
		href="javascript:showOrHideSubSection('SubSection54', 'ShowHideImage54', 'ShowHideLink54')">
			<img id="ShowHideImage54" src="<%=EPiServer.Global.EPConfig.RootDir%>util/images/EditorGuide/arrowdown.gif" />Förklara svåra och ovanliga begrepp
		</a>
	</h3>
	<div id="SubSection54" class="hidden">
		<p>
			Ord och begrepp som är självklara för dig och din verksamhet kan vara svåra att förstå för den som inte är insatt. Försök därför att hitta ett bra sätt att förklara svåra ord och ovanliga begrepp.
		</p>
		<p>
			Om det finns enklare ord som betyder samma sak som ett svårare ord så bör du använda det enklare ordet.
		</p>
	</div>
	<h3>	
		<a id="ShowHideLink55" title="<%= EPiServer.Global.EPLang.TranslateForScript("/edit/editorguide/showsection") %>"
		href="javascript:showOrHideSubSection('SubSection55', 'ShowHideImage55', 'ShowHideLink55')">
			<img id="ShowHideImage55" src="<%=EPiServer.Global.EPConfig.RootDir%>util/images/EditorGuide/arrowdown.gif" />Skriv helst ut förkortningar och akronymer
		</a>
	</h3>
	<div id="SubSection55" class="hidden">
		<p>
			Förkortningar och akronymer kan skapa problem. En akronym är en förkortning som man kan läsa som ett eget ord. Det är inte säkert att användaren förstår en förkortning. Generellt gäller därför att undvika förkortningar. 
		</p>
		<p>
			De förkortningar som du använder kan behöva förklaras. Det finns flera sätt att göra det: Antingen skriver du ut förkortningen i klartext. Det bör ske åtminstone den första gången förkortningen förekommer i en text. Ett annat tänkbart alternativ är att förklara förkortningar (och andra viktiga eller svåra begrepp) i en ordlista.
		</p>
	</div>
	<h3>	
		<a id="ShowHideLink56" title="<%= EPiServer.Global.EPLang.TranslateForScript("/edit/editorguide/showsection") %>"
		href="javascript:showOrHideSubSection('SubSection56', 'ShowHideImage56', 'ShowHideLink56')">
			<img id="ShowHideImage56" src="<%=EPiServer.Global.EPConfig.RootDir%>util/images/EditorGuide/arrowdown.gif" />Datumformat
		</a>
	</h3>
	<div id="SubSection56" class="hidden">
		<p>
			Uppläsande programvaror kan ha svårt att hantera datum. Vilken användare som helst kan ha problem med att förstå datum om datum presenteras på olika sätt på olika delar av webbplatsen. Därför bör alla datum, både de som skapas automatiskt av olika listningar eller skrivs ut direkt i mallarna och de som skapas manuellt av redaktörer skrivas på samma sätt. Det ger användaren en bättre möjlighet att förstå och hantera datum. Rekommenderat sätt att skriva datum är: år-månad-dag. 
		</p>
		<p>
			Den här meningen skrevs till exempel 2005-07-08, vilket är enligt det rekommenderade sättet att skriva datum.
		</p>
	</div>
	<h2>
		Lättlästa versioner och teckenspråk
	</h2>
	<p>
		För vissa användare räcker det inte med att den ordinarie webbplatsen görs så bra som möjligt. Dessa användare har behov av kompletterande information anpassad till deras speciella förutsättningar. 
	</p>
	<h3>	
		<a id="ShowHideLink57" title="<%= EPiServer.Global.EPLang.TranslateForScript("/edit/editorguide/showsection") %>"
		href="javascript:showOrHideSubSection('SubSection57', 'ShowHideImage57', 'ShowHideLink57')">
			<img id="ShowHideImage57" src="<%=EPiServer.Global.EPConfig.RootDir%>util/images/EditorGuide/arrowdown.gif" />Lättläst
		</a>
	</h3>
	<div id="SubSection57" class="hidden">
		<p>
			För personer med begåvningshandikapp och för personer som har svårt att behärska det svenska språket finns ett sätt att skriva som kallas "Lättläst". Med hjälp av detta sätt att skriva så kan texten förenklas så att den blir lättare att förstå. Det finns särskilda utbildningar för att lära sig att skriva lättläst.
		</p>
		<p>
			Här kommer ett exempel (Källa: Centrum för lättläst, <a href="http://www.lattlast.se" target="_blank">www.lattlast.se</a>):
		</p>
		<p>
			Så här kan en text se ut före:
			<br />
			"När man lämnar sitt land får man en helt ny livssituation. Man lämnar ett känt sammanhang och ett gemensamt språk. Man förlorar den tillvaro där man hade sin identitet och trygghet. Man förstår inte språket, samspelet och koderna i det nya landet."
		</p>
		<p>
			Så här kan texten se ut efter:
			<br />
			"Det är svårt att flytta till ett annat land. Du kan inte prata med människorna där. Du vet inte hur de hälsar på varandra eller tackar."
		</p>
	</div>
	<h3>	
		<a id="ShowHideLink58" title="<%= EPiServer.Global.EPLang.TranslateForScript("/edit/editorguide/showsection") %>"
		href="javascript:showOrHideSubSection('SubSection58', 'ShowHideImage58', 'ShowHideLink58')">
			<img id="ShowHideImage58" src="<%=EPiServer.Global.EPConfig.RootDir%>util/images/EditorGuide/arrowdown.gif" />Teckenspråk
		</a>
	</h3>
	<div id="SubSection58" class="hidden">
		<p>
			För döva kan det vara viktigt att få viss information på det egna språket – teckenspråket. Sådant material läggs upp som filmer på webbplatsen. Många döva har mycket lättare för att förstå information som ges på teckenspråk jämfört med skriftlig information på svenska. Som ett komplement till en text kan det därför behövas en teckenspråkig information.
		</p>
	</div>
</div>

<div id="Section6" class="hidden">
	<h1>
		Färger och kontraster
	</h1>
	<h2>
		Användarens färguppfattningsförmåga
	</h2>
	<p>
		Om du bara använder färg för att förmedla information kan användare med försämrad färguppfattningsförmåga inte ta del av information på det sätt det är tänkt. Ett exempel är om du gör viss text röd för att markera något viktigt. Används färger för att förmedla information är det extra viktigt att informationen också förmedlas på annat sätt. Röd färg tillsammans med fet stil är därför bättre än enbart röd färg i exemplet ovan.
	</p>
	<p>
		För att vara säker på att sidor fungerar även om användaren inte kan uppfatta färgen kan du testa sidan genom att titta på den på en svartvit bildskärm eller genom att skriva ut den på en svartvit skrivare. 
	</p>
	<h2>
		Kontraster
	</h2>
	<p>
		När förgrunds- och bakgrundfärger ligger för nära varandra i färgskalor och ljushet får vissa användare problem med läsbarheten. Välj färger som ger god kontrast och därmed bättre läsbarhet för alla människor. Läshastighet och möjlighet till avståndsläsning hänger starkt samman med kontraster. Bra kontrast ger till exempel: svart text på vit bakgrund, grönt på vitt, blått på vitt och svart på gult.
	</p>
	<p>
		Använd endast förgrunds- och bakgrundsfärger som tillsammans ger tillräcklig kontrastverkan. 
	</p>
	<p>
		Ett sätt att testa om skillnaderna mellan färger är tillräcklig är att mäta skillnaden i ljushet mellan de två färgerna. Skillnaden mellan färgerna ska ligga på minst 50 enheter på en 100 gradig skala. Om du har tillgång till Adobe Photoshop så kan du mäta skillnaden i färgvärden enligt ovan.
	</p>
	<h2>
		Varför är det här viktigt?
	</h2>
	<p>
		Alla uppfattar inte färg likadant. Viss utrustning återger färg på ett felaktigt sätt och många har svårt att läsa text där kontrasten är för liten. 
	</p>
</div>
