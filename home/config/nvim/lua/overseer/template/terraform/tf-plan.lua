return {
  name = "Terraform plan",
  builder = function()
    return {
      cmd = { "terraform" },
      args = { "plan" },
      components = { { "on_output_quickfix", open = true }, "default" },
    }
  end,
  condition = {
    filetype = { "terraform" },
  },
}
