import * as uriJson from './uri.json'

export class ReaderAI {

  async readDocument(prompt: string) {
    console.log('process.env.H2OGPT_LINK',process.env.H2OGPT_LINK)
    const response = await fetch(`${process.env.H2OGPT_LINK}/${uriJson.completions}`, {
      method: 'POST',
      body: JSON.stringify({
        document: prompt
      })
    });
    return {response};
  }


}