const api_key = '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';
import OpenAI from "openai";
const openai = new OpenAI({ apiKey: api_key });

try{
let params_json_encoded = process.argv[2];
let jsonAsString = Buffer.from(params_json_encoded, "base64").toString("ascii");
let queryObj = JSON.parse(jsonAsString);

const getFormattedQuery = () => {
    // Formulate the query based on the provided structure
    let formattedQuery = `
        Question: ${queryObj.question}

        Paper: ${queryObj?.paper}
        Words: 250
        Keywords: ${queryObj?.keyword_array?.join(' ')} 

        Give examples. Follow Introduction 20% Body 60% and Conclusion 20% format of answer. Give Current Relevant. Give Future looking, solution providing positive conclusion.
    `;

    return formattedQuery;
};

(async () => {
    try {
        // Make the API call to OpenAI
        const response = await openai.chat.completions.create({
            model: "gpt-3.5-turbo",
            messages: [{role: "user", content: getFormattedQuery()}],
            temperature: 0.5,
            max_tokens: 1000,
            top_p: 1,
          });

        // Log the generated content
        // console.log(response.choices[0].message.content);
        console.log(JSON.stringify({answer: response.choices[0].message.content, usage: response.usage.total_tokens}, null, 2))
    } catch (error) {
        // Handle errors
        console.error('Error:', error.message || error);
    }
})();

}catch(error){
    console.log(JSON.stringify({error: error.toString()}))
}
