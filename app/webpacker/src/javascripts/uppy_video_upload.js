
window.setupVideoUploadUppy = function () {
    const Uppy = require('@uppy/core')
    const Form = require('@uppy/form')
    const FileInput = require('@uppy/file-input')
    const ProgressBar = require('@uppy/progress-bar')
    const AwsS3 = require('@uppy/aws-s3')
    const ms = require('ms')

    const uppy = new Uppy({
        restrictions: {
            maxNumberOfFiles: 1,
            allowedFileTypes: ['video/mp4']
        },
        allowMultipleUploads: false,
        autoProceed: true
    })
    uppy.use(AwsS3, {
        timeout: ms('1 minute'),
        getUploadParameters(file) {
            // Send a request to our PHP signing endpoint.
            return fetch(
                '/s3/fetch_signed_url',
                {
                    method: 'post',
                    // Send and receive JSON.
                    headers: {
                        accept: 'application/json',
                        'content-type': 'application/json'
                    },
                    body: JSON.stringify({
                        filename: file.name,
                        contentType: file.type
                    })
                })
                .then((response) => {
                    // Parse the JSON response.
                    console.log('presign response', response);
                    return response.json();
                })
                .then((data) => {
                    // Return an object in the correct shape.
                    return {
                        method: data.method,
                        url: data.url,
                        fields: data.fields,
                        // Provide content type header required by S3
                        headers: {
                            'Content-Type': file.type
                        }
                    };
                });
        }
    }).use(ProgressBar, {
        target: '.uppy_progress_bar',
        hideAfterFinish: false
    }).use(Form, {
        target: '#video_library_form',
        resultName: 'video',
        getMetaFromForm: false,
        addResultToForm: true,
        multipleResults: true,
        submitOnSuccess: false,
        triggerUploadOnSubmit: false
    }).use(FileInput, {
        target: '.UppyForm',
        replaceTargetContent: true
    })

    uppy.on('upload-success', (file, response) => {
        console.log(response);
        if(response.status === 200) {
            alert('Completed uploaded');
        } else {
            alert('Something went wrong.');
        }
    })
}
$(document).on('turbolinks:load', function() {
    if(document.getElementById('video_library_form')) {
        window.setupVideoUploadUppy();
    }
});