import 'dart:io';

import 'package:flutter/material.dart';
import 'package:span_builder/span_builder.dart';

class PrivacyPolicy extends StatefulWidget {
  PrivacyPolicy({Key key}) : super(key: key);

  @override
  _PrivacyPolicyState createState() => _PrivacyPolicyState();
}

class _PrivacyPolicyState extends State<PrivacyPolicy> {
  ValueKey span_key = ValueKey("span_key");
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        automaticallyImplyLeading: false,
        title: Text(
          'Privacy Policy',
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.bold,
            color: Colors.black,
            fontFamily: 'Comfortaa',
          ),
        ),
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: Icon(
            Platform.isAndroid ? Icons.arrow_back : Icons.arrow_back_ios,
            color: Colors.black,
          ),
        ),
      ),
      backgroundColor: Colors.white,
      body: Container(
        height: height,
        width: width,
        padding: EdgeInsets.only(
            left: width / 20, right: width / 20, bottom: width / 20),
        child: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: SizedBox(
                height: height / 80,
              ),
            ),
            SliverToBoxAdapter(
              child: Text(
                'SHARING OUT PRIVATE LIMITED',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                  fontFamily: 'Comfortaa',
                ),
              ),
            ),
            space(context),
            space(context),
            sp('Summary of Privacy Policy'),
            sp1('We take your right to privacy very seriously and so before you download the Sharing Out app, please take a few moments to read how we collect and use your data. You can also read our full Privacy Policy below.Sharing Out is known as the ‘Controller’ of the personal data provided to us.',
                'Privacy Policy'),
            space(context),
            sp1('Why we need your data We need to collect this information about you when you sign up and each time you use the app so that you can get the most out of Sharing Out.',
                'Why we need your data '),
            sp1('•	We do not collect sensitive information such as any medical details.',
                '•	We do not collect '),
            sp1('•	We store ',
                '•	We store your personal information carefully.'),
            sp('You have consented to provide this information to us but can withdraw your consent at any time by getting in touch with us (info@rywo.org). '),
            sp1('What we do with your data We retain personal information only for as long as necessary to carry out these functions. If you notify us that you no longer wish to be listed on the database we will delete your information as soon as possible.',
                'What we do with your data '),
            SliverToBoxAdapter(
              child: SizedBox(
                height: height / 30,
              ),
            ),
            sp1('•	We use your data to provide information to you about items available nearby.',
                '•	We use '),
            sp1('•	We may use your information to contact you about our service and goods and services that we believe that you may be interested in.',
                '•'),
            SliverToBoxAdapter(
              child: SizedBox(
                height: height / 30,
              ),
            ),
            sp1('•	We do not share your information with anyone unless we are required to do so by law or it is necessary to make the app run properly.',
                '•	We do not share '),
            sp1('•	We do not sell your information to anyone.All the personal data we process is located on servers within the Pakistan. ',
                '•	We do not sell '),
            SliverToBoxAdapter(
              child: SizedBox(
                height: height / 30,
              ),
            ),
            SliverToBoxAdapter(
              child: Text(
                'What are your rights?',
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                  fontFamily: 'Comfortaa',
                ),
              ),
            ),
            space(context),
            sp('You have a right to see the information we hold on you and/or require your data to be deleted by making a request in writing to the email address below. If at any point you believe the information we process on you is incorrect you can request to have it corrected. If you wish to raise a complaint on how we have handled your personal data, you can contact us and we will investigate the matter.'),
            sp1('•	You can adjust ',
                '•	You can adjust your preferences in the settings menu on the app.'),
            sp1('•	You can request access to your information or ask us to delete it by contacting us.If you are not satisfied with our response or believe we are processing your personal data not in accordance with the law you can complain to the Information Commissioner’s Office (ICO).',
                '•	You can request '),
            sp1('If you agree to the above, download the app. If you do not agree or would like some further information then please contact us at info@sharingout.org .',
                'If you do not agree '),
            SliverToBoxAdapter(
              child: SizedBox(
                height: height / 30,
              ),
            ),
            SliverToBoxAdapter(
              child: Container(
                width: width,
                child: Builder(
                    builder: (context) => Center(
                            child: SpanBuilderWidget(
                          key: span_key,
                          text: SpanBuilder(
                            "PRIVACY POLICY",
                          ),
                          defaultStyle: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                            fontFamily: 'Comfortaa',
                          ),
                          textAlign: TextAlign.left,
                        ))),
              ),
            ),
            SliverToBoxAdapter(
              child: SizedBox(
                height: height / 30,
              ),
            ),
            SliverToBoxAdapter(
              child: Text(
                '1.	Introduction',
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                  fontFamily: 'Comfortaa',
                ),
              ),
            ),
            space(context),
            sp2('1.1 Sharing Out Private Limited (“Company” or “We“) respect your privacy and are committed to protecting it through our compliance with this policy. This policy describes: ',
                'Company', 'We'),
            sp1('•	The identity of the data controller.', '•	'),
            sp2('•	What personal data is collected including the types of information we may collect or that you may provide when you download, access or use the Sharing Out app (the “App“). Note: for the purposes of this policy both the website www.sharingout.org and the Sharing Out application shall be referred to as the “App”.',
                '•	', 'App'),
            sp1('•	How personal data is collected.', '•	'),
            sp1('•	Why personal data is collected.', '•	'),
            sp1('•	How we use personal data.', '•	'),
            sp1('•	How personal data is shared and with whom.', '•	'),
            sp1('•	What choices you have with respect to how personal data is used.',
                '•	'),
            sp1('•	How long personal data is kept.', '•	'),
            sp1('', '•	'),
            sp2('•	Your rights with respect to personal data.1.2 This policy applies only to information we collect in the App, via e-mail, text and other electronic communications sent through or in connection with the App This policy DOES NOT apply to information that:',
                '•	', 'DOES NOT '),
            sp1('•	We collect offline or on any other Company apps or websites (other than www.sharingout.org), including websites you may access through this App. ',
                '•	'),
            sp1('•	You provide to or is collected by any third party (see “THIRD-PARTY INFORMATION COLLECTION” (unless this information is provided by them to us)).',
                '•	'),
            sp('1.3 Please note, we may have a separate privacy policy for our other websites and apps and third parties may have their own privacy policies, which we encourage you to read before providing information on or through them.'),
            sp('1.4 Please read this policy carefully to understand our policies and practices regarding your information and how we will treat it. A SUMMARY OF THIS POLICY IS ALSO AVAILABLE. If you do not agree with our policies and practices, do not download, register with or use this App. By downloading, registering with or using this App and, where applicable, ticking our consent boxes, you agree to this privacy policy. This policy may change from time to time (see “CHANGES TO OUR PRIVACY POLICY”). Unless such changes mean changes to your preferences, your continued use of this App after we make changes is deemed to be acceptance of those changes, so please check the policy periodically for updates. '),
            space(context),
            sp1('1.5 Users under the Age of 18: The App is not intended for anyone under 18 years of age, and we do not knowingly collect personal information from anyone under 18. If we learn we have collected or received personal information from anyone under 18 without verification of parental consent, we will delete that information. If you believe we might have any information from or about a user under 18, please contact us at: info@sharingout.org.',
                '1.5 Users under the Age of 18: '),
            SliverToBoxAdapter(
              child: SizedBox(
                height: height / 30,
              ),
            ),
            SliverToBoxAdapter(
              child: Text(
                '2.	Identity of Data Controller',
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                  fontFamily: 'Comfortaa',
                ),
              ),
            ),
            space(context),
            sp('2.1 A data controller is a person or organisation who makes decisions about how your personal data is collected, used and handled.'),
            sp('2.2 The Company is the data controller and may be contacted at:'),
            sp1('•	Post:  Sharing Out Private Limited, office no: 1, First Floor, Serfraz Market, KRL road, Rawalpindi, Punjab, Pakistan. ',
                '•'),
            sp1('•	e-mail:  info@sharingout.org', '•'),
            SliverToBoxAdapter(
              child: SizedBox(
                height: height / 30,
              ),
            ),
            SliverToBoxAdapter(
              child: Text(
                '3.	What personal data is collected',
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                  fontFamily: 'Comfortaa',
                ),
              ),
            ),
            space(context),
            sp('3.1 We collect information from and about users of our App:'),
            sp1('•	Directly from you when you provide it to us.', '•'),
            sp1('•	Automatically when you use the App.', '•'),
            sp('3.2 We do not collect special categories of personal data such as information relating to or about the below or information about criminal records.'),
            sp1('•	Health ', '•'),
            sp1('•	Racial or ethnic origin', '•'),
            sp1('•	Political opinions', '•'),
            sp1('•	Membership of a political association, professional or trade association ',
                '•'),
            sp1('•	Membership of a trade union', '•'),
            sp1('•	Religious beliefs or affiliations', '•'),
            sp1('•	Philosophical beliefs', '•'),
            sp1('•	Sexual orientation or practices', '•'),
            sp1('•	Biometric information ', '•'),
            sp('3.3 Information that you provide to us (“personal information”) when you download, register with or use this App may include:'),
            sp1('•	First Name, Last Name;', '•'),
            sp1('•	Postal address;', '•'),
            sp1('•	E-mail address;', '•'),
            sp1('•	Telephone number; and ', '•'),
            sp1('•	Profile picture.', '•'),
            sp('3.4 In addition we may collect other information that is about you but individually does not identify you, such as age or gender.'),
            sp('3.5 This information may also include:'),
            sp1('•	Information that you provide by filling in forms in the App such as first name, last name, email address, telephone number and address (“Contact Information”). This includes information provided at the time of registering to use the App and requesting further services. ',
                '•'),
            sp1('•	We may also ask you for information when you enter a contest or promotion sponsored by us, such as your Contact Information.',
                '•'),
            sp1('•	Information you provide to us when you complete user surveys or surveys for research purposes such as your Contact Information.',
                '•'),
            sp1('•	Information you provide to us when you report a problem with the App such as your first name, last name and email address.',
                '•'),
            sp1('•	Records and copies of your correspondence (including e-mail addresses and phone numbers), if you contact us.',
                '•'),
            sp1('•	Details of transactions you carry out through the App and of the fulfilment of your orders. ',
                '•'),
            sp1('•	Your correspondence within the App with other users (your username and location).',
                '•'),
            sp('3.6 Third-party Information Collection'),
            sp('3.6.1 When you use the App or its content, certain third parties may use automatic information collection technologies to collect information about you or your device. These third parties may include: '),
            sp1('•	Advertisers, ad networks and ad servers.', '•'),
            sp1('•	Analytics companies.', '•'),
            sp1('•	Your mobile device manufacturer.', '•'),
            sp1('•	Your mobile service provider.', '•'),
            sp('3.6.2 These third parties may use tracking technologies to collect information about you when you use the App. The information they collect may be associated with your personal information or they may collect information, including personal information, about your online activities over time and across different websites, apps and other online services or websites. They may use this information to provide you with interest-based (behavioural) advertising or other targeted content. '),
            sp('3.6.3 We do not control these third parties’ tracking technologies or how they may be used. If you have any questions about an advertisement or other targeted content, you should contact the responsible provider directly. '),
            sp('3.6.4 For information about how you can opt out of receiving targeted advertising from many providers, see “CHOICES ABOUT HOW WE USE AND DISCLOSE YOUR INFORMATION”.'),
            SliverToBoxAdapter(
              child: SizedBox(
                height: height / 30,
              ),
            ),
            SliverToBoxAdapter(
              child: Text(
                '4.	How personal data is collected.',
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                  fontFamily: 'Comfortaa',
                ),
              ),
            ),
            space(context),
            sp('4.1 Automatic Information Collection and Tracking. '),
            sp('4.1.1 When you download, access and use the App, it may use technology to automatically collect:'),
            sp1('•	Usage Details. When you access and use the App, we may automatically collect certain details of your access to and use of the App, including traffic data, location data, logs and other communication data and the resources that you access and use on or through the App. ',
                '•'),
            sp1('•	Device Information. We may collect information about your mobile device and internet connection, including the device’s unique device identifier, IP address, operating system, browser type, mobile network information and the device’s telephone number.',
                '•'),
            sp1('•	Stored Information and Files. The App also may access metadata and other information associated with other files stored on your device. This may include, for example, photographs, audio and video clips, personal contacts and address book information. You will be asked for your consent to such access and use of your personal data within the App.  You can withdraw your consent at any time via the settings menu.',
                '•'),
            sp1('•	Location Information. This App collects real-time information about the location of your device. We do not, however, continually collect user location data nor do we collect location data without the user being aware. We store the location of a user at set points for example when you choose to update your location and when you create/edit an item. Some of our location-enabled Services require your personal data for the feature to work. You will be asked for your consent to such access and use of your personal data within the App.  Note, however, that opting out of the App’s collection of location information will cause its location-based features to be disabled. You can withdraw your consent at any time via the settings menu.',
                '•'),
            sp('4.2 If you do not want us to collect this information, please do not create an account with us. '),
            sp('4.3 We may also use these technologies to collect information about your activities over time and across third-party websites, apps or other online services (behavioural tracking). '),
            sp('4.4 Information Collection and Tracking Technologies. '),
            sp('4.4.1 The technologies we use for automatic information collection may include:'),
            sp1('•	Cookies (or mobile cookies). A cookie is a small file placed on your smartphone or device. It may be possible to refuse to accept mobile cookies by activating the appropriate setting on your smartphone or device. However, if you select this setting you may be unable to access certain parts of our App.',
                '•'),
            sp1('•	The cookies we use include “analytical” cookies. They allow us to recognise and count the number of visitors and to see how visitors move around the App when they are using it. This helps us to improve the way our App works, for example, by ensuring that users are finding what they are looking for easily.',
                '•'),
            sp1('•	These cookies are used to collect information about how visitors use our App. We use the information to compile reports on general user traffic, conversion statistics and to help us improve the site. The cookies collect information anonymously.Please note that our advertisers may also use cookies, over which we have no control.',
                '•'),
            sp1('•	Third Party Cookies.  The App may link to other websites owned and operated by certain trusted third parties (for example Facebook) who, for example, collect data that helps us to track conversions from Facebook ads. These other third party websites may also use cookies or similar technologies in accordance with their own separate polices. Please note that our advertisers may also use cookies, over which we have no control.  For privacy information relating to these other third party websites, please consult their policies as appropriate',
                '•'),
            SliverToBoxAdapter(
              child: SizedBox(
                height: height / 30,
              ),
            ),
            SliverToBoxAdapter(
              child: Text(
                '4.5 Third Party Software/Services',
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                  fontFamily: 'Comfortaa',
                ),
              ),
            ),
            space(context),
            sp('4.5.1 At this point we don’t use any third party software/  services. '),
            SliverToBoxAdapter(
              child: SizedBox(
                height: height / 30,
              ),
            ),
            SliverToBoxAdapter(
              child: Text(
                '5.	How we use personal data and lawful bases for processing',
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                  fontFamily: 'Comfortaa',
                ),
              ),
            ),
            space(context),
            sp('5.1 Lawful Bases for Processing under the Pakistan’s LawWhat are the lawful bases for processing personal data? The lawful bases for processing are set out under Pakistan’s Law.   At least one of these must apply whenever we process personal data. We mainly use consent, contract, legal obligations and legitimate interests as the bases to process your personal data in accordance with this privacy policy.'),
            sp1('1.	Consent: the individual has given clear consent for us to process their personal data for a specific purpose. ',
                '1.	Consent:'),
            sp1('2.	Contract: the processing is necessary for a contract we have with the individual, or because they have asked us to take specific steps before entering into a contract. ',
                '2.	Contract:'),
            sp1('3.	Legal obligation: the processing is necessary for us to comply with the law (not including contractual obligations). ',
                '3.	Legal obligation: '),
            sp1('4.	Legitimate interests: the processing is necessary for our legitimate interests or the legitimate interests of a third party unless there is a good reason to protect the individual’s personal data which overrides those legitimate interests. 5.1 We use information that we collect about you or that you provide to us, including any personal information, to:',
                '4.	Legitimate interests:'),
            sp1('•	To set up and operate your Sharing Out account (such processing is necessary for the performance of our contract with you).',
                '• '),
            sp1('•	To verify your identity and carry out security checks in order to set up your account (such processing is necessary for the performance of our contract with you and necessary for us to comply with a legal obligation).',
                '• '),
            sp1('•	Provide you with the App and its contents, and any other information, products or services that you request from us (such processing is necessary for the performance of our contract with you).',
                '• '),
            sp1('•	Give you notices about your account, including expiration and renewal notices (such processing is necessary for the performance of our contract with you and necessary for us to comply with a legal obligation).',
                '• '),
            sp1('•	Ensure that content from our App is presented in the most effective manner for you and for your computer or device for accessing the App (such processing is necessary for the performance of our contract with you).',
                '• '),
            sp1('•	Carry out our obligations and enforce our rights arising from any contracts entered into between you and us, including for billing and collection (such processing is necessary for our legitimate interests (to recover monies due etc).',
                '• '),
            sp1('•	Notify you when App updates are available, and of changes to any products or services we offer or provide though it (such processing is necessary for our legitimate interests (to allow us to provide changes to our software, products or services)).',
                '• '),
            sp1('•	To collect information from surveys that you sign up to take part in (such processing is necessary for our legitimate interests (to improve our services)).',
                '• '),
            sp1('•	To manage your account, including processing payments and refunds and providing notifications, should this service be introduced within the App (such processing is necessary for the performance of our contract with you and is necessary for our legitimate interests (to process payments)).',
                '• '),
            sp1('6.2 The usage information we collect helps us to improve our App and to deliver a better and more personalised experience by enabling us to:',
                '• '),
            sp1('•	Estimate our audience size and usage patterns (such processing is necessary for our legitimate interests (for running our services and to study how users use our App).',
                '• '),
            sp1('•	Store information about your preferences, allowing us to customize our App according to your individual interests (such processing is necessary for our legitimate interests (for running our services).',
                '• '),
            sp1('•	Speed up your searches (such processing is necessary for our legitimate interests (for running our services).',
                '• '),
            sp1('•	Recognise you when you use the App (such processing is necessary for the performance of our contract).',
                '• '),
            sp1('•	To provide us with information about how the App is running or whether there are any faults or issues with our products and services (such processing is necessary for our legitimate interests (for us to deliver a better service to you).6.3 We use location data for the following reasons: ',
                '• '),
            sp1('•	To provide information about food or non-food items within a fixed distance from the user’s set location (such information is necessary for the performance of our contract with you).',
                '• '),
            sp1('•	To allow others to receive information about a user’s food or non-food items within their search radius (such information is necessary for the performance of our contract with you).',
                '• '),
            sp('6.4 We may also use your information to contact you about news, offers, notifications, surveys, information, goods and services that we think may be of interest to you (such processing is done with your consent and is necessary for our legitimate interests (to develop our products/services and grow our business)). We give you the option to consent to such emails when you sign up for the App. If you do not want us to use your information in this way, please do not consent.  You may adjust your user preferences in your account profile. For more information, see section 8.0 below.'),
            sp('6.5 We have implemented reasonable measures designed to secure your personal information from accidental loss and from unauthorised access, use, alteration and disclosure.'),
            sp('6.6 The safety and security of your information also depends on you. Where we have given you (or where you have chosen) a password for access to certain parts of our App, you are responsible for keeping this password confidential. We ask you not to share your password with anyone. We urge you to be careful about giving out information in public areas of the App like message boards. The information you share in public areas may be viewed by any user of the App.'),
            sp('6.7 Unfortunately, the transmission of information via the internet and mobile platforms is not completely secure. Although we do our best to protect your personal information, we cannot guarantee the security of your personal information transmitted through our App. Any transmission of personal information is at your own risk. We are not responsible for circumvention of any privacy settings or security measures we provide. '),
            sp('6.8 If you suspect that there has been a breach of the security of your data you should contact us at: info@sharingout.org and include details of: '),
            sp1('•	the nature of the breach; ', '• '),
            sp1('•	the date of the breach; and', '• '),
            sp1('•	the full circumstances of the breach. 6.9 On notification of such a breach we will investigate the matter and, where appropriate and required by law, notify the relevant Data Protection Regulator.',
                '• '),
            SliverToBoxAdapter(
              child: SizedBox(
                height: height / 30,
              ),
            ),
            SliverToBoxAdapter(
              child: Text(
                '7.	How personal data is shared and with whom.',
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                  fontFamily: 'Comfortaa',
                ),
              ),
            ),
            space(context),
            sp('7.1 You may provide information to be published or displayed (“Posted“) on public areas of the App (collectively, “User Contributions“). Your User Contributions are Posted and transmitted to others at your own risk. We cannot control the actions of third parties with whom you may choose to share your User Contributions. Therefore, we cannot and do not guarantee that your User Contributions will not be viewed by unauthorised persons.'),
            sp('7.2 We may disclose aggregated information about our users, and information that does not identify any individual or device, without restriction.'),
            sp('7.3 In addition, we may disclose personal information that we collect or you provide:'),
            sp1('•	To our subsidiaries and affiliates.', '•'),
            sp1('•	To contractors, service providers and other third parties we use to support our business and who are bound by contractual obligations to keep personal information confidential and use it only for the purposes for which we disclose it to them.',
                '•'),
            sp1('•	To a buyer or other successor in the event of a merger, divestiture, restructuring, reorganisation, dissolution or other sale or transfer of some or all of the Company’s assets, whether as a going concern or as part of bankruptcy, liquidation or similar proceeding, in which personal information held by the Company about our App users is among the assets transferred.',
                '•'),
            sp1('•	To fulfil the purpose for which you provide it. For example, if you give us an e-mail address to use the “e-mail a friend” feature of our App, we will transmit the contents of that e-mail and your e-mail address to the recipients.',
                '•'),
            sp1('•	For any other purpose disclosed by us when you provide the information.',
                '•'),
            sp1('•	For the purposes of academic research.', '•'),
            sp1('•	For any other purpose with your consent.', '•'),
            sp1('•	To comply with any court order, law or legal process, including to respond to any government or regulatory request.',
                '•'),
            sp1('•	To enforce our rights arising from any contracts entered into between you and us.',
                '•'),
            sp1('•	If we believe disclosure is necessary or appropriate to protect the rights, property, or safety of the Company, our customers or others. This includes exchanging information with other companies and organisations for the purposes of fraud protection and credit risk reduction.',
                '•'),
            SliverToBoxAdapter(
              child: SizedBox(
                height: height / 30,
              ),
            ),
            SliverToBoxAdapter(
              child: Text(
                '8.	What choices you have with respect to how personal data is used.',
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                  fontFamily: 'Comfortaa',
                ),
              ),
            ),
            space(context),
            sp('8.1 We strive to provide you with choices regarding the personal information you provide to us. This section describes mechanisms we provide for you to control certain uses and disclosures of your information. You may need to adjust the settings on your device to restrict the collection of information by the App but this may prevent you from accessing all of the features of the App. '),
            sp1('•	Tracking Technologies. You may be able to set your browser or device to refuse all or some browser cookies, or to alert you when cookies are being sent. If you disable or refuse cookies or block the use of other tracking technologies, some parts of the App may then be inaccessible or not function properly.',
                '•'),
            sp1('•	Location Information. You can choose whether or not to allow the App to collect and use real-time information about your device’s location through the device’s privacy settings. If you block the use of location information, some parts of the App may then be inaccessible or not function properly. For example, users have the ability to only allow manual geolocation (rather than using their device’s autolocating functionality), the provision of at least one piece of location data (i.e. their search location) is a requirement for the app to function.',
                '•'),
            sp1('•	Promotion by the Company. If you do not want us to use your e-mail address or other contact information to send you information, notifications, news, surveys or promote our own products or services, you can opt-out by logging into the App and adjusting your user preferences in your account profile by checking or unchecking the relevant boxes or by sending us an e-mail stating your request to info@sharingout.org. ',
                '•'),
            sp1('•	Targeted Advertising by the Company. We do not use information that we collect or that you provide to us to deliver advertisements.',
                '•'),
            sp1('•	Disclosure of Your Information for Third-Party Advertising and Marketing. We do not share your personal information with third parties for advertising and marketing purposes.  However, we may include offers from third parties in our marketing materials.',
                '•'),
            sp('8.2 We do not control third parties’ collection or use of your information to serve interest-based advertising. However, these third parties may provide you with ways to choose not to have your information collected or used in this way.  '),
            SliverToBoxAdapter(
              child: SizedBox(
                height: height / 30,
              ),
            ),
            SliverToBoxAdapter(
              child: Text(
                'Your rights with respect to personal data.',
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                  fontFamily: 'Comfortaa',
                ),
              ),
            ),
            space(context),
            sp('9.1 You can review and change your personal information by logging into the App and visiting your account settings page. '),
            sp('9.2 You may also send us an e-mail at info@sharingout.org to request access to, correct or delete any personal information free of charge that you have provided to us. We cannot delete your personal information except by also deleting your user account. '),
            sp('9.3 We will respond to a request to access, correct or delete any data within 30 days of the date we receive the request. '),
            sp('9.4 We may not accommodate a request to change information if we believe the change would violate or breach any law or legal requirement or cause the information to be incorrect. '),
            sp('9.5 If, on your request, we refuse to amend, correct or delete your personal information, we will set out our reasons for not doing so and provide you with details of how you may complain about our refusal.'),
            sp('9.6 If you delete your User Contributions from the App, copies of your User Contributions may remain viewable in cached and archived pages, or might have been copied or stored by other App users. Proper access and use of information provided on the App, including User Contributions, is governed by our Terms and Conditions. '),
            SliverToBoxAdapter(
              child: SizedBox(
                height: height / 30,
              ),
            ),
            SliverToBoxAdapter(
              child: Text(
                '10 How long personal data is kept.',
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                  fontFamily: 'Comfortaa',
                ),
              ),
            ),
            space(context),
            sp('10.1 We will only retain personal data for as long as is reasonably necessary.'),
            sp('10.2 Upon deletion of an account, all personal data will be removed as soon as possible, and always within 90 days of the deletion.'),
            SliverToBoxAdapter(
              child: SizedBox(
                height: height / 30,
              ),
            ),
            SliverToBoxAdapter(
              child: Text(
                '11.	Changes to Our Privacy Policy',
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                  fontFamily: 'Comfortaa',
                ),
              ),
            ),
            space(context),
            sp('11.1 We may update our privacy policy from time to time. If we make material changes to how we treat our users’ personal information, we will post the new privacy policy on this page with a notice that the privacy policy has been updated.'),
            sp('11.2 The date the privacy policy was last revised is identified at the top of the page. You are responsible for periodically visiting this privacy policy to check for any changes.'),
            SliverToBoxAdapter(
              child: SizedBox(
                height: height / 30,
              ),
            ),
            SliverToBoxAdapter(
              child: Text(
                '12 Contact Information',
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                  fontFamily: 'Comfortaa',
                ),
              ),
            ),
            space(context),
            sp('12.1 All questions, comments and requests regarding this privacy policy should be addressed to the contact details as set out in the App and on www.sharingout.org or by e-mail to info@sharingout.org.')
          ],
        ),
      ),
    );
  }

  Widget space(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    return SliverToBoxAdapter(
      child: SizedBox(
        height: height / 100,
      ),
    );
  }

  Widget sp(String text) {
    return SliverToBoxAdapter(
      child: Container(
        child: Builder(
            builder: (context) => Align(
                  alignment: Alignment.centerLeft,
                  child: SpanBuilderWidget(
                    key: span_key,
                    text: SpanBuilder(
                      "$text",
                    ),
                    defaultStyle: TextStyle(
                      fontSize: 11,
                      color: Colors.black45,
                      fontFamily: 'Comfortaa',
                    ),
                    textAlign: TextAlign.start,
                  ),
                )),
      ),
    );
  }

  Widget sp1(String text, String heading) {
    return SliverToBoxAdapter(
      child: Container(
        child: Builder(
            builder: (context) => Align(
                  alignment: Alignment.centerLeft,
                  child: SpanBuilderWidget(
                    key: span_key,
                    text: SpanBuilder(
                      "$text",
                    )..apply(TextSpan(
                        text: "$heading",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 11,
                          color: Colors.black,
                          fontFamily: 'Comfortaa',
                        ))),
                    defaultStyle: TextStyle(
                      fontSize: 11,
                      color: Colors.black45,
                      fontFamily: 'Comfortaa',
                    ),
                    textAlign: TextAlign.start,
                  ),
                )),
      ),
    );
  }

  Widget sp2(String text, String heading, String heading2) {
    return SliverToBoxAdapter(
      child: Container(
        child: Builder(
            builder: (context) => Align(
                  alignment: Alignment.centerLeft,
                  child: SpanBuilderWidget(
                    key: span_key,
                    text: SpanBuilder(
                      "$text",
                    )
                      ..apply(TextSpan(
                          text: "$heading",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 11,
                            color: Colors.black,
                            fontFamily: 'Comfortaa',
                          )))
                      ..apply(TextSpan(
                          text: "$heading2",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 11,
                            color: Colors.black,
                            fontFamily: 'Comfortaa',
                          ))),
                    defaultStyle: TextStyle(
                      fontSize: 11,
                      color: Colors.black45,
                      fontFamily: 'Comfortaa',
                    ),
                    textAlign: TextAlign.start,
                  ),
                )),
      ),
    );
  }
}
