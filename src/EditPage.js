import React, { Component } from 'react';
import Editor from 'draft-js-editor'

class EditPage extends React.Component {

  state = {};

  render() {
    return <div>
      A sample text editor
      <Editor
        onChange={(editorState) => this.setState({ editorState })}
        editorState={this.state.editorState}
      />
    </div>
  }
}

export default EditPage;
