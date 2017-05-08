function UpdatePageLink()
{
	if(!window.parent.parent.latestVersion)
		window.parent.parent.latestVersion = window.parent.parent.latestNavigate;
		
	if(window.parent.parent.latestVersion!=null && window.parent.parent.latestVersion!='')
	{
		var form = getForm();
		var nQPos = form.action.indexOf('?id=');
		var nAmpPos = form.action.indexOf('&id=');
		if(nQPos>0)
			form.action = form.action.slice(0,nQPos+4) + window.parent.parent.latestVersion + form.action.substring(form.action.indexOf('&',nQPos));
		else if(nAmpPos>0)
		{
			form.action = form.action.slice(0,nAmpPos+4) + window.parent.parent.latestVersion;
			if(form.action.indexOf('&',nAmpPos+1)>0)
			 form.action = form.action.substring(form.action.indexOf('&',nAmpPos+1))
		}
		else
			form.action = form.action + "&id=" + window.parent.parent.latestVersion;
		
	}
}

function HideTab(n)
{
	if(n==1)
	{
		Tab1.style.display = 'none';
		Tab1Body.style.display = 'none';
	}
	else
	{
		Tab2.style.display = 'none';
		Tab2Body.style.display = 'none';
	}

}

function OpenTab(n)
{
	if(document.all['Tab1']==null)
		return;

	// U H D V
	if(n==1)
	{
		Tab1.className = 'WF-LeftTabSelected';
		Tab1Body.className = 'WF-TabBodyVisible';
	}
	else
	{
		Tab1.className = 'WF-LeftTab';
		Tab1Body.className = 'WF-TabBodyHidden';
	}
	
	if(n==2)
	{
		Tab2.className = 'WF-RightTabSelected';
		Tab2Body.className = 'WF-TabBodyVisible';
	}
	else
	{
		Tab2.className = 'WF-RightTab';
		Tab2Body.className = 'WF-TabBodyHidden';
	}
}
