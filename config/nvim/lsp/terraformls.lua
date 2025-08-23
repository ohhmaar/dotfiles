return {
	cmd = { "terraform-ls", "serve" },           -- Command to start the Terraform language server
	filetypes = { "terraform", "terraform-vars" }, -- File types that this server will handle
	root_markers = { ".terraform", "*.tf", ".git" }, -- Markers to identify the root of the project
	settings = {                                 -- Settings for the language server
		terraformls = {
			experimentalFeatures = {
				validateOnSave = true,
				prefillRequiredFields = true,
			},
		},
	},
}