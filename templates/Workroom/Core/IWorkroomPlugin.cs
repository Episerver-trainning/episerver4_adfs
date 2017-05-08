using System;

namespace development.Templates.Workrooms.Core
{
	interface IWorkroomPlugin
	{
		string Name
		{
			get;
		}

		Boolean IsActive
		{
			get;
			set;
		}
		
		Boolean IsActiveEditable
		{
			get;
		}

		/// <summary>
		/// If true, this plugin has been properly initialized (containers etc have been defined) and can be activated.
		/// </summary>
		Boolean IsInitialized
		{
			get;
		}
	}
}
