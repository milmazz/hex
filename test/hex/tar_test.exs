defmodule Hex.TarTest do
  test "unpack should copy hex_metadata.config" do
    meta = %{
      name: :ex_doc,
      app: :ex_doc,
      version: "0.0.1",
      build_tools: ["mix"],
      requirements: [],
      licenses: ["MIT"],
      description: "pear"
    }

    path = "#{meta[:name]}-#{meta[:version]}.tar"

    dest = "dest"

    in_tmp fn ->
      {tar, _checksum} = Hex.Tar.create(meta, [], false)
      
      Hex.State.put(:home, tmp_path())

      File.mkdir!(dest)

      Hex.Tar.unpack(path, dest, repo, meta.name, meta.version)

      assert File.exists?(Path.join(dest, "hex_metadata.config"))
    end
  end
end