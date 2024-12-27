require 'fox16'
require_relative "StudentListView"
include Fox

app = FXApp.new
StudentListView.new(app)
app.create
app.run