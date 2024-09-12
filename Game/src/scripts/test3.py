def create_txt_file(filename, content):
  """
  Creates a new text file with the specified content.

  Args:
    filename: The name of the file to create.
    content: The content to write to the file.
  """

  with open(filename, "w") as f:
    f.write(content)

  print(f"File '{filename}' created successfully.")




create_txt_file("my_file.txt", "This is the content of the file.")