/// <reference path="linq.d.ts" />
declare namespace pages {
    class index extends Bootstrap {
        readonly appName: string;
        protected init(): void;
    }
}
declare namespace pages {
    class login extends Bootstrap {
        readonly appName: string;
        protected init(): void;
        private doLogin;
        private doCheckLogin;
    }
}
declare namespace pages {
    class home extends Bootstrap {
        readonly appName: string;
        protected init(): void;
    }
}
declare namespace pages {
    class share_photo extends Bootstrap {
        readonly appName: string;
        protected init(): void;
        private doUpload;
    }
}
declare namespace pages {
    class edit_profile extends Bootstrap {
        readonly appName: string;
        protected init(): void;
    }
}
declare namespace webapp {
    function start(): void;
}
declare namespace webapp {
    function hookImagePreviews(inputId: string, previewImgId: string): void;
}
