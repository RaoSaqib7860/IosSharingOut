import 'dart:io';

import 'package:flutter/material.dart';
import 'package:span_builder/span_builder.dart';

const nbsp = '\u00A0';

class TersAndConditions extends StatefulWidget {
  TersAndConditions({Key key}) : super(key: key);

  @override
  _TersAndConditionsState createState() => _TersAndConditionsState();
}

class _TersAndConditionsState extends State<TersAndConditions> {
  ValueKey span_key = ValueKey("span_key");
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          automaticallyImplyLeading: false,
          title: Text(
            'Terms and Conditions',
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
                  'Sharing Out Private Limited ',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                    fontFamily: 'Comfortaa',
                  ),
                ),
              ),
              SliverToBoxAdapter(
                child: SizedBox(
                  height: height / 80,
                ),
              ),
              SliverToBoxAdapter(
                child: Text(
                  'TERMS AND CONDITIONS',
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                    fontFamily: 'Comfortaa',
                  ),
                ),
              ),
              space(context),
              sp2('Please note, Sharing Out’s use of “Buyer”, “Seller”, “Sell” and “Purchase” below are for ease of reference only.  ALL items offered or requested on the Sharing Out app must be FREE OF CHARGE.',
                  'ALL', 'FREE OF CHARGE'),
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
                              "This document sets out the terms and conditions (“Terms”) on which you (“you” or “User”) may use:",
                            )
                              ..apply(const TextSpan(
                                  text: "Terms",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 12,
                                    color: Colors.black,
                                    fontFamily: 'Comfortaa',
                                  )))
                              ..apply(const TextSpan(
                                  text: "you",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 12,
                                    color: Colors.black,
                                    fontFamily: 'Comfortaa',
                                  )))
                              ..apply(const TextSpan(
                                  text: "User",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 12,
                                    color: Colors.black,
                                    fontFamily: 'Comfortaa',
                                  ))),
                            defaultStyle: TextStyle(
                              fontSize: 11,
                              color: Colors.black45,
                              fontFamily: 'Comfortaa',
                            ),
                            textAlign: TextAlign.left,
                          ))),
                ),
              ),
              SliverToBoxAdapter(
                child: SizedBox(
                  height: height / 80,
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
                              "i) the Sharing Out Private Limited (“Sharing Out, “us” “we” or “our”) website at www.sharingout.org; and",
                            )
                              ..apply(const TextSpan(
                                  text: "Sharing Out, ",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 12,
                                    color: Colors.black,
                                    fontFamily: 'Comfortaa',
                                  )))
                              ..apply(const TextSpan(
                                  text: "us",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 12,
                                    color: Colors.black,
                                    fontFamily: 'Comfortaa',
                                  )))
                              ..apply(const TextSpan(
                                  text: "we",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 12,
                                    color: Colors.black,
                                    fontFamily: 'Comfortaa',
                                  )))
                              ..apply(const TextSpan(
                                  text: "our",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 12,
                                    color: Colors.black,
                                    fontFamily: 'Comfortaa',
                                  ))),
                            defaultStyle: TextStyle(
                              fontSize: 11,
                              color: Colors.black45,
                              fontFamily: 'Comfortaa',
                            ),
                            textAlign: TextAlign.left,
                          ))),
                ),
              ),
              SliverToBoxAdapter(
                child: SizedBox(
                  height: height / 80,
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
                              "ii) the Sharing Out application, for the purposes of these Terms, both the website and the application shall be referred to as the “App”.",
                            )..apply(const TextSpan(
                                text: "App",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 12,
                                  color: Colors.black,
                                  fontFamily: 'Comfortaa',
                                ))),
                            defaultStyle: TextStyle(
                              fontSize: 11,
                              color: Colors.black45,
                              fontFamily: 'Comfortaa',
                            ),
                            textAlign: TextAlign.left,
                          ))),
                ),
              ),
              sp1('The App facilitates the Sale and Purchase of Food and/or Items through the Platform.Please read these terms carefully before using the App. By using the App, you agree to comply with and be legally bound by these Terms, whether or not you become a registered User of the Services. These Terms govern your access to and use of the App and constitute a binding legal agreement between you and Sharing Out. You are advised to print and retain a copy of these Terms for your future reference.',
                  'App'),
              SliverToBoxAdapter(
                child: SizedBox(
                  height: height / 80,
                ),
              ),
              sp1('•	Section A contains general provisions which apply to all Users of the App.',
                  '•'),
              sp1('•	Section B applies to Buyers.', '•'),
              sp1('•	Section C applies to Sellers.', '•'),
              sp('For the purposes of these Terms:'),
              sp1('“Buyer” means the purchaser or recipient of an Item or Items offered for Sale;',
                  'Buyer'),
              sp1('“Food” means food or foodstuffs, or drinks; ', 'Food'),
              sp1('“Items” means food items;', 'Items'),
              sp1('“Platform” means the App’s software as a service platform;',
                  'Platform'),
              sp1('“Purchase” means requesting to buy for payment or any other form of ',
                  'Purchase'),
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
                              "SECTION A: GENERAL PROVISIONS",
                            ),
                            defaultStyle: TextStyle(
                              fontSize: 12,
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
                  '1.INFORMATION ABOUT SHARING OUT AND THE APP',
                  style: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                    fontFamily: 'Comfortaa',
                  ),
                ),
              ),
              space(context),
              sp('1.1 The App is owned, managed, operated and maintained by Sharing Out Private Limited, (company number: 0152130), and having its registered address at Office no:1, First Floor, Serfraz Market, KRL Road, Rawalpindi, Punjab, Pakistan. '),
              space(context),
              sp2('1.2 Sharing Out is an online marketplace which allows Users to advertise (“Add”) Items on the Platform for the purpose of making a Sale to other Users.  The App also allows Users to search for (“Browse”) Items to Purchase.',
                  'Add', 'Browse'),
              space(context),
              sp2('1.3 The Users can also create personal Sharing Out profiles (“Profiles”), communicate with other Sharing Out Users and Sharing Out (via the forum and otherwise), provide feedback on their experiences and use such other Services (“Services”) available on the App from time to time.',
                  'Profiles', 'Services'),
              space(context),
              sp('1.4 Sharing Out shall be entitled at its own discretion to suspend the App for any reason whatsoever, including, but not limited to, repairs, planned maintenance or upgrades to the App or Platform.  Sharing Out shall not be liable to you for any losses, damages, costs or expenses arising from or in connection with any suspension or unavailability of the App, including, but not limited to, preventing you from using the Platform or using any of the Services available on the App.'),
              space(context),
              sp('1.5 Sharing Out reserves the right to make any changes to the App including any functionalities and content therein or to discontinue any aspect of the same without notice to you.'),
              space(context),
              sp('1.6 Sharing Out relies on third party providers (such as network providers, data centres and telecommunication providers) to make and host the App and the content therein and the Services available to you. Whilst Sharing Out takes all reasonable steps available to it to provide you with a good level of service, you acknowledge and agree that Sharing Out does not warrant that the App shall be uninterrupted or fault-free at all times. Sharing Out therefore shall not be liable in any way for any losses, damages, costs or expenses you may suffer as a result of delays or failures of the Services and App as a result of Sharing Out or its service providers.'),
              space(context),
              sp('1.7 Sharing Out may be contacted at Office no:1, First Floor, Serfraz Market, KRL Road, Rawalpindi, Punjab, Pakistan or by email at: info@sharingout.org.'),
              SliverToBoxAdapter(
                child: SizedBox(
                  height: height / 30,
                ),
              ),
              SliverToBoxAdapter(
                child: Text(
                  '2. WARRANTIES',
                  style: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                    fontFamily: 'Comfortaa',
                  ),
                ),
              ),
              space(context),
              sp('2.1 By registering your details with Sharing Out as a User, you warrant that:'),
              space(context),
              sp('2.11 you are legally capable of entering into binding contracts;'),
              space(context),
              sp('2.12 you are at least 18 years old;'),
              space(context),
              sp('2.13 the information provided by you to Sharing Out is true, accurate and correct. You further warrant that you shall promptly notify Sharing Out in the event of any changes to such information; and'),
              space(context),
              sp('2.14 you are not in any way prohibited by the applicable law in the jurisdiction in which you are currently located to enter into these Terms for the use of the Services and Sale of Items.'),
              SliverToBoxAdapter(
                child: SizedBox(
                  height: height / 30,
                ),
              ),
              SliverToBoxAdapter(
                child: Text(
                  '3. REGISTRATION',
                  style: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                    fontFamily: 'Comfortaa',
                  ),
                ),
              ),
              space(context),
              sp1('3.1 In order to browse items or complete a transaction as a Buyer or Seller within the App, you must firstly complete the registration form and set up an account as an Sharing Out User (“Account”). ',
                  'Account'),
              space(context),
              sp('3.2 All registered Users are able to use the App both as a Buyer and a Seller, and are subject to the Terms in relation to Buyer and Seller, as applicable.'),
              space(context),
              sp('3.3 When you register with Sharing Out you will be asked if you agree to these Terms; the End User License Agreement and agree to your personal data being used in accordance with our Privacy Policy.'),
              space(context),
              sp('3.4 Sharing Out may give you the opportunity to invite friends by email, SMS, Facebook or WhatsApp to join the App. Sharing Out is not liable for any communication that you make via such third party applications, websites or other forms of media.'),
              space(context),
              sp1('3.5 You shall keep your registration details for the App (“Login Details”) confidential and secure. Without prejudice to any other rights and remedies available to Sharing Out, Sharing Out reserves the right to promptly disable your Login Details and suspend your access to the App in the event that Sharing Out has any reason to believe you have breached any of the provisions in these Terms.',
                  'Login Details'),
              space(context),
              sp1('3.6 Notwithstanding the foregoing, Sharing Out reserves the right to:',
                  'Login Details'),
              space(context),
              sp('3.6.1 accept or reject your application to register for any reason; and'),
              space(context),
              sp('3.6.2 suspend your Account and/or refuse you access to the Services and/or App (partly or wholly) if you breach any of the provisions in these Terms.'),
              space(context),
              sp('3.6.3 No action or inaction on the part of Sharing Out to exercise its rights in accordance with 3.6.1 and/or 3.6.2 shall be taken as an acceptance of any actions or inactions on your part.'),
              SliverToBoxAdapter(
                child: SizedBox(
                  height: height / 30,
                ),
              ),
              SliverToBoxAdapter(
                child: Text(
                  '4. USER OBLIGATIONS',
                  style: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                    fontFamily: 'Comfortaa',
                  ),
                ),
              ),
              space(context),
              sp('4.1 You agree that you are solely responsible and liable for all activities carried out by your use of the App, including, but not limited to, for the content of any communication made when using or about the App.'),
              space(context),
              sp1('4.2 You shall not upload to the App (through your use of the Services), any information, reviews, comments, images, third party URL links or other material whatsoever in any format (“User Submissions”), whether within your personal Profile, when submitting a review in relation to another User or elsewhere on the App that, in Sharing Out’s reasonable opinion, may be deemed to be offensive, illegal, inappropriate or that in any way:',
                  'User Submissions'),
              space(context),
              sp('4.2.1 promotes racism, bigotry, hatred, homophobia or physical harm of any kind against any group or individual;'),
              space(context),
              sp('4.2.2 harasses or advocates harassment of another person;'),
              space(context),
              sp('4.2.5 promotes any illegal activities;'),
              space(context),
              sp('4.2.6 provides instructional information about illegal activities, including violating someone else’s privacy or providing or creating computer viruses;'),
              space(context),
              sp('4.2.7 promotes or contains information that you know or believe to be inaccurate, false or misleading;'),
              space(context),
              sp('4.2.8 engages in or promotes commercial activities and/or sales, including but not limited to contests, sweepstakes, barter, advertising and pyramid schemes, without the prior written consent of Sharing Out; or'),
              space(context),
              sp('4.2.9 infringes any rights of any third party (including, but not limited to, their intellectual property rights).'),
              space(context),
              sp('4.3 You acknowledge that making a User Submission does not guarantee that such User Submission, or any part thereof, shall appear on the App whether or not the submission of such User Submission is part of the Services. You agree that Sharing Out may, at its sole discretion, choose to display or to remove any User Submission or any part of the same that you make on the App, and you hereby grant to Sharing Out a non-exclusive, perpetual, irrevocable, worldwide license to do so.'),
              space(context),
              sp('4.4 You hereby grant to Sharing Out a non-exclusive, irrevocable licence to make the User Submissions available to other Users of the App.'),
              space(context),
              sp('4.5 If you believe that any User Submission made by another User is inappropriate, please contact Sharing Out using info@sharingout.org. Sharing Out shall use its reasonable endeavours to review the relevant User Submission as soon as is practicable and shall take such action as it deems necessary, if any at all. If a User Submission is deemed to be in breach of these Terms, Sharing Out reserves the right at its absolute discretion to suspend a User Account.'),
              space(context),
              sp('4.5 You further agree that at all times, you shall:'),
              space(context),
              sp('4.6 not use your Login Details with the intent of impersonating another person;'),
              space(context),
              sp('4.6.1 not allow any other person to use your Login Details;'),
              space(context),
              sp('4.6.2 not use the information presented on the App or provided to you by Sharing Out for any commercial purposes;'),
              space(context),
              sp('4.6.3 not do anything likely to impair, interfere with or damage or cause harm or distress to any persons using the App;'),
              space(context),
              sp('4.6.4 not infringe any rights of any third parties (including, but not limited to, their intellectual property rights);'),
              space(context),
              sp('4.6.5 comply with all instructions and policies from Sharing Out from time to time in respect of the use of the Platform, the Services and the App;'),
              space(context),
              sp('4.6.6 co-operate with any reasonable security or other checks or requests for information made by Sharing Out from time to time; and'),
              space(context),
              sp('4.6.7 use the information made available to you on the App and through the Services at your own risk.'),
              space(context),
              sp('4.6.8 In the event that you have a dispute with any other User of the App, you hereby release Sharing Out from any claims, demands, losses. expenses and damages (whether direct, indirect actual or consequential) of any kind and nature, known and unknown, arising out of or in connection with such dispute.'),
              SliverToBoxAdapter(
                child: SizedBox(
                  height: height / 30,
                ),
              ),
              SliverToBoxAdapter(
                child: Text(
                  '5. EXCLUSION OF WARRANTIES AND SHARING OUT’S LIMITATION OF LIABILITY',
                  style: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                    fontFamily: 'Comfortaa',
                  ),
                ),
              ),
              space(context),
              sp('5.1 Subject to conditions 5.4 and 5.5, if Sharing Out fails to comply with these Terms, Sharing Out shall be given a reasonable opportunity to rectify any errors and to re-perform its obligations hereunder. If Sharing Out’s failure to comply with its obligations is not remedied in accordance with this clause 5.1, then Sharing Out shall only be liable for losses, damages, costs or expenses which are a reasonably foreseeable consequence of such failure (whether arising in contract, tort (including negligence) or otherwise), up to a maximum of five thousand rupees (PKR5000).'),
              space(context),
              sp('5.2 Further, you acknowledge and agree that where the App includes views, opinions, advice or recommendations, such views, opinions, advice and recommendations are not attributed to Sharing Out nor are they endorsed by Sharing Out and to the maximum extent permitted by law, Sharing Out excludes all liability for the accuracy, defamatory nature, completeness, timeliness, suitability or otherwise of such views, opinions, advice or recommendations.'),
              space(context),
              sp('5.3 Sharing Out does not routinely monitor or control any User Submission, or other information made available to you through your use of the Platform, the Services and/or the App. Consequently, Sharing Out does not warrant or guarantee the accuracy, correctness, reliability or suitability in respect of any User Submission or any other information made available to you through your Sale or Purchase of the Items offered, the Services and/or the App. Sharing Out cannot advise you or assist you in making or refraining from making a decision, or in deciding on a course or specific cause of action. If you intend to use and/or rely upon any User Submission or any other information made available to you through your use of the Platform, the Services and/or the App, you do so at your own risk and liability.  If Sharing Out is made aware that a User Submission is incorrect, it may correct the User Submission as it sees fit. For example, if a Food has been incorrectly labelled/categorised as a non-food Item.'),
              space(context),
              sp('5.4 In accordance with condition 4.5, other Users may report to Sharing Out any User Submission that is deemed by the other User to be incorrect or inappropriate and Sharing Out will investigate all such reports and reserves the right to deal with the User Submission and the User, as it sees fit.'),
              space(context),
              sp('5.5 Subject to condition 5.6, Sharing Out shall not be liable for losses (whether caused by tort (including negligence), breach of contract or otherwise, even if foreseeable) that result from its failure to comply with these Terms that fall into the following categories:'),
              space(context),
              sp('5.5.1 consequential, indirect or special losses;'),
              space(context),
              sp('5.5.2 loss of profits, income or revenue;'),
              space(context),
              sp('5.5.3 loss of savings or anticipated savings, interest or production;'),
              space(context),
              sp('5.5.4 loss of business or business benefits;'),
              space(context),
              sp('5.5.5 loss of contracts;'),
              space(context),
              sp('5.5.6 loss of opportunity or expectations;'),
              space(context),
              sp('5.5.7 loss of goodwill and/or reputation;'),
              space(context),
              sp('5.5.8 loss of marketing and/or public relations time and/or opportunities;'),
              space(context),
              sp('5.5.9 loss of data; '),
              space(context),
              sp('5.5.10 loss of management or office time; or'),
              space(context),
              sp('5.5.11 any other losses howsoever arising.'),
              space(context),
              sp('5.6 Nothing in these Terms excludes or limits Sharing Out’s liability for:'),
              space(context),
              sp('5.6.1 death or personal injury caused by its negligence;'),
              space(context),
              sp('5.6.2 fraud or fraudulent misrepresentation by Sharing Out; or'),
              space(context),
              sp('5.6.3 any other matter for which it would be illegal for Sharing Out to exclude or attempt to exclude its liability.'),
              space(context),
              sp('5.6.4 Commentary and other materials posted on the App or provided by Sharing Out are not intended to amount to advice on which reliance should be placed. Sharing Out '),
              space(context),
              sp('therefore disclaims all liability and responsibility arising from any reliance placed on such materials by any User of the App, or by anyone who may be informed of any of its contents. Further, responsibility for decisions taken on the basis of information, suggestions and advice given to you by Sharing Out shall remain solely with you.5.7 Sharing Out does not in any way participate nor shall it be liable in any way for whatever reason for any communication, transaction, meet-up, set-up or relationship between you and other Users. Sharing Out therefore recommends that you take all safety precautions when contacting, socialising and engaging in social gatherings or meetings, including without limitation with regard to the Sale and Purchase of Items, with other Users.'),
              SliverToBoxAdapter(
                child: SizedBox(
                  height: height / 30,
                ),
              ),
              SliverToBoxAdapter(
                child: Text(
                  '6. INTELLECTUAL PROPERTY RIGHTS',
                  style: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                    fontFamily: 'Comfortaa',
                  ),
                ),
              ),
              space(context),
              sp('6.1 Sharing Out and its licensors own all the intellectual property rights in and relating to the App, Services and Platform. '),
              space(context),
              sp('6.2 You are expressly prohibited from:'),
              space(context),
              sp('6.2.1 reproducing, copying, editing, transmitting, uploading or incorporating into any other materials, any of the App except for the purposes of sharing content on social media such as Twitter, Facebook, etc; and'),
              space(context),
              sp('6.2.2 removing, modifying, altering or using any registered or unregistered marks/logos/designs owned by Sharing Out or its licensors, and doing anything which may be seen to take unfair advantage of the reputation and goodwill of Sharing Out or could be considered an infringement of any of the rights in the intellectual property rights owned by and/or licensed to Sharing Out.'),
              space(context),
              sp('6.3 Provided that Sharing Out is unaware of any infringement of any third party intellectual property rights at the time you submit any User Submissions, Sharing Out shall not be liable in any way to you or any third party for any breach of such rights subsequently notified to you or Sharing Out.'),
              SliverToBoxAdapter(
                child: SizedBox(
                  height: height / 30,
                ),
              ),
              SliverToBoxAdapter(
                child: Text(
                  '7 PRIVACY AND DATA PROTECTION',
                  style: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                    fontFamily: 'Comfortaa',
                  ),
                ),
              ),
              space(context),
              sp1('7.1 We will only use your personal information as set out in our Privacy Policy',
                  'Privacy Policy'),
              SliverToBoxAdapter(
                child: SizedBox(
                  height: height / 30,
                ),
              ),
              SliverToBoxAdapter(
                child: Text(
                  '8. FORCE MAJEURE',
                  style: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                    fontFamily: 'Comfortaa',
                  ),
                ),
              ),
              space(context),
              sp1('8.1 Sharing Out shall not be liable or responsible for any failure to perform, or delay in performance of, any of its obligations under these Terms that is caused by events outside its reasonable control (“Force Majeure Event”).',
                  'Force Majeure Event'),
              space(context),
              sp('8.2 A Force Majeure Event includes any act, event, non-happening, omission or accident beyond Sharing Out’s reasonable control and includes in particular (without limitation) the following:'),
              space(context),
              sp('8.2.1 strikes, lock-outs or other industrial action;'),
              space(context),
              sp('8.2.2 civil commotion, riot, invasion, terrorist attack or threat of terrorist attack, war (whether declared or not) or threat or preparation for war;'),
              space(context),
              sp('8.2.3 fire, explosion, storm, flood, earthquake, subsidence, epidemic or other natural disaster;'),
              space(context),
              sp('8.2.4 impossibility of the use of railways, shipping, aircraft, motor transport or other means of public or private transport;'),
              space(context),
              sp('8.2.5 impossibility of the use of public or private telecommunications networks; and'),
              space(context),
              sp('8.2.6 the acts, decrees, legislation, regulations or restrictions of any government.'),
              space(context),
              sp('8.3 Sharing Out’s performance under these Terms is deemed to be suspended for the period that the Force Majeure Event continues, and Sharing Out shall have an extension of time for performance for the duration of that period. Sharing Out will use its reasonable endeavours to bring the Force Majeure Event to a close or to find a solution by which its obligations under these Terms may be performed despite the Force Majeure Event.'),
              SliverToBoxAdapter(
                child: SizedBox(
                  height: height / 30,
                ),
              ),
              SliverToBoxAdapter(
                child: Text(
                  '9. COMPLAINTS AND TERMINATION',
                  style: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                    fontFamily: 'Comfortaa',
                  ),
                ),
              ),
              space(context),
              sp1('9.1 If you wish to lodge a complaint about another User for breaching any of these Terms, you may do so by sending Sharing Out details of your complaint by emailing info@sharingout.org. Sharing Out will use its reasonable endeavours to respond to your complaints within a reasonable time and to take reasonable action which it deems appropriate to resolve or rectify the subject matter of such complaints.',
                  'info@sharingout.org'),
              space(context),
              sp('9.2 Sharing Out may suspend or terminate your use of the Services and/or App if:'),
              space(context),
              sp('9.2.1 any of Sharing Out third party communication network providers cease to make their services available to Sharing Out for any reason;'),
              space(context),
              sp('9.2.2 Sharing Out believes you or someone using your login details has failed to comply with one or more of these Terms;'),
              space(context),
              sp('9.2.3 Sharing Out believes there has been fraudulent use, misuse or abuse of the Services; or'),
              space(context),
              sp('9.2.4 Sharing Out believes you have provided any false, inaccurate or misleading information.'),
              space(context),
              sp('9.2.5 On termination, your access to the App shall cease and Sharing Out may delete your Profile.'),
              SliverToBoxAdapter(
                child: SizedBox(
                  height: height / 30,
                ),
              ),
              SliverToBoxAdapter(
                child: Text(
                  '10. GENERAL',
                  style: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                    fontFamily: 'Comfortaa',
                  ),
                ),
              ),
              space(context),
              sp('10.1 If Sharing Out fails at any time to insist upon strict performance of its obligations under these Terms, or if it fails to exercise any of the rights or remedies to which it is entitled under these Terms, this will not constitute a waiver of any such rights or remedies and shall not relieve you from compliance with such obligations.'),
              space(context),
              sp('10.2 A waiver by Sharing Out of any default shall not constitute a waiver of any subsequent default.'),
              space(context),
              sp('10.3 No waiver by Sharing Out of any of these Terms shall be effective unless it is expressly stated to be a waiver and is communicated to you in writing.'),
              space(context),
              sp('10.4 For the avoidance of doubt, references to ‘writing’ shall be deemed to include email.'),
              space(context),
              sp('10.5 Sharing Out reserves the right to use third party suppliers or sub-contractors at any time and in any way, in respect of the performance of its obligations under these Terms.'),
              space(context),
              sp('10.6 If any of these Terms is determined by any competent authority to be invalid, unlawful or unenforceable to any extent, such term, condition or provision will to that extent be severed from the remaining terms, conditions and provisions which shall continue to be valid to the fullest extent permitted by law.'),
              space(context),
              sp('10.7 These Terms and any document expressly referred to in them represent the entire agreement between you and Sharing Out in respect of your use of the App and your use of the Platform and the Services, and shall supersede any prior agreement, understanding or arrangement between you and Sharing Out, whether oral or in writing.'),
              space(context),
              sp('10.8 You acknowledge that in entering into these Terms, you have not relied on any representation, undertaking or promise given by or implied from anything said or written whether on the App, the internet or in negotiation between you and Sharing Out except as expressly set out in these Terms.'),
              space(context),
              sp('10.9 Sharing Out may alter or amend our Terms by giving you reasonable notice. By continuing to use the App after expiry of the notice period, or accepting the amended Terms (as we may decide at our sole discretion), you will be deemed to have accepted any amendment to these Terms. If, on receipt of such notice, you wish to terminate your access to the App, you may do so by giving us not less than 7 (seven) day’s written notice, (which may be by e-mail), such termination to take effect on the date upon which the amended Terms would otherwise have come into effect.'),
              space(context),
              sp('10.10 These Terms are governed by and construed in accordance with Pakistan law. The Courts of Pakistan shall have exclusive jurisdiction over any disputes arising out of these Terms. '),
              space(context),
              sp('10.11 If any dispute arises in connection with these Terms, the parties will attempt to settle it by correspondence and for business users by mediation in accordance with the available Mediation Procedure. Unless otherwise agreed between the parties within 14 days of notice of the dispute, the mediator will be nominated by concerned authority.'),
              space(context),
              sp('10.12 The mediation will take place in Islamabad, Pakistan and the language of the mediation will be Urdu or English. The Mediation Agreement referred to in the Model Procedure shall be governed by, and construed and take effect in accordance with the substantive law of Pakistan. If the dispute is not settled by mediation within 14 days of commencement of the mediation or within such further period as the parties may agree in writing, the dispute shall be referred to the courts of Pakistan.'),
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
                              "SECTION B: BUYERS’ TERMS AND CONDITIONS",
                            ),
                            defaultStyle: TextStyle(
                              fontSize: 12,
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
                  '11. INTRODUCTION',
                  style: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                    fontFamily: 'Comfortaa',
                  ),
                ),
              ),
              space(context),
              sp('Upon registration as a User, and in consideration of your compliance with these terms and conditions, Sharing Out will provide you with the Buyer Services as described in this section B. You are a Buyer if you request and make arrangements to collect or receive any Items (for free or for payment) through the App.'),
              SliverToBoxAdapter(
                child: SizedBox(
                  height: height / 30,
                ),
              ),
              SliverToBoxAdapter(
                child: Text(
                  '12. BUYER SERVICES',
                  style: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                    fontFamily: 'Comfortaa',
                  ),
                ),
              ),
              space(context),
              sp('12.1 Subject to condition 1.5 of Section A above, the Buyer Services will comprise of the following:'),
              space(context),
              sp('12.1.1 the facility to create a Profile page (including a photo) which can be accessed by the Sellers;'),
              space(context),
              sp('12.1.2 the ability to search for Items offered from Sellers who have registered with the App; '),
              space(context),
              sp('12.1.3 the ability to communicate with other Sellers using the App;'),
              space(context),
              sp('12.1.4 the facility to review and/or submit feedback on Sellers; and'),
              space(context),
              sp('12.1.5 access to any other features and functionality for the Buyer Services provided by Sharing Out to Buyers from time to time.'),
              space(context),
              sp('12.2 You acknowledge and agree that all transactions are subject to acceptance by the Sellers. The contract for fulfilment of a transaction is created between you and the Seller, which will only be formed once you have received such acceptance. Sharing Out is not responsible for either party’s performance under such a contract and Sharing Out makes no guarantee that the obligations of either party under the contract will be fulfilled.'),
              SliverToBoxAdapter(
                child: SizedBox(
                  height: height / 30,
                ),
              ),
              SliverToBoxAdapter(
                child: Text(
                  '13. ADDITIONAL OBLIGATIONS AS A BUYER',
                  style: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                    fontFamily: 'Comfortaa',
                  ),
                ),
              ),
              space(context),
              sp('13.1 You must at all times use the Buyer Services and the App in accordance with these Terms. In particular, all content and material uploaded to or forming part of your Profile must comply with the rules relating to User Submissions set out in Section A of these Terms.'),
              space(context),
              sp('13.2 As a Buyer, you are responsible for:'),
              space(context),
              sp('13.2.1 ascertaining the identity of any Sellers;'),
              space(context),
              sp('13.2.2 verifying the Price of any Items, which you acknowledge will be determined at the Seller’s sole discretion;'),
              space(context),
              sp('13.2.3 ensuring you have sufficient information relating to any health & safety risks, including ascertaining that the Seller is, where applicable, registered or licensed as appropriate with the relevant authority. This may include being registered or licensed as a food business;'),
              space(context),
              sp('13.2.4 any review of Seller to be fair, honest and reasonable; and'),
              space(context),
              sp('13.2.5 verification of all information provided by the Seller in relation to any food items provided, including the ingredients and allergy information.'),
              space(context),
              sp('13.3 In using the Buyer Services, you must:'),
              space(context),
              sp('13.3.1 not provide information (including in your Profile) which you know to be inaccurate, false, incomplete, untrue or is or may be deemed to be a misrepresentation of the facts; and'),
              space(context),
              sp('13.3.2 immediately notify Sharing Out in the event you have any reason to believe or suspect that a Seller has breached any of the terms under Section A or that any Seller Profile is not genuine, or is false, inaccurate and/or incomplete.'),
              SliverToBoxAdapter(
                child: SizedBox(
                  height: height / 30,
                ),
              ),
              SliverToBoxAdapter(
                child: Text(
                  '14. ADDITIONAL EXCLUSION OF WARRANTIES',
                  style: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                    fontFamily: 'Comfortaa',
                  ),
                ),
              ),
              space(context),
              sp('14.1 You acknowledge and agree that the Services provided by Sharing Out are limited to providing you with a forum to attempt to source Items and connect you with Sellers. When you use the Buyer Services, Sharing Out does not warrant or guarantee:'),
              space(context),
              sp('14.1.1 that you will find Items suitable to your specific tastes, dietary needs or other requirements;'),
              space(context),
              sp('14.1.2 the status of any Seller as a business or that they are compliant with any standards set by the relevant food competent authority (such as Pakistan: Food Standards Authority); '),
              space(context),
              sp('14.1.3 the premises used by a Seller are suitable for cooking and preparing or, where applicable, registered with their local environmental health department;'),
              space(context),
              sp('14.1.4 that the Sellers’ Profiles are genuine;'),
              space(context),
              sp('14.1.5 that any information or documentation made available on a Seller’s Profile is authentic, valid, accurate or otherwise complete; or'),
              space(context),
              sp('14.1.6 the identity of the Seller using the App.'),
              space(context),
              sp('14.2 Sharing Out is not responsible in any way for the quality or supply of any Items by the Sellers. Such items are to be provided by the Sellers on terms and conditions as may be agreed between you and the Seller.'),
              space(context),
              sp('14.3 In the event there is a dispute between you and any Seller, or if the Items provided by a Seller are not provided to a satisfactory standard or at all, you agree Sharing Out is not liable (including but not limited to any loss, damages, costs or expenses or personal injury) suffered or incurred by you in the course of receiving such Items from a Seller, and you release and hold harmless Sharing Out from anything you may suffer or any liability in relation to such dispute.'),
              SliverToBoxAdapter(
                child: SizedBox(
                  height: height / 30,
                ),
              ),
              SliverToBoxAdapter(
                child: Text(
                  '15. DONATIONS MADE VIA THE SHARING OUT APP',
                  style: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                    fontFamily: 'Comfortaa',
                  ),
                ),
              ),
              SliverToBoxAdapter(
                child: SizedBox(
                  height: height / 30,
                ),
              ),
              SliverToBoxAdapter(
                child: Text(
                  '15.1 DONATIONS GENERAL',
                  style: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                    fontFamily: 'Comfortaa',
                  ),
                ),
              ),
              space(context),
              sp('15.1.1 The Seller may provide the Buyer, with the option to make a financial donation prior to the supply of any Items.'),
              space(context),
              sp2('15.1.2 Donations referred to in condition 15.1.1 may be made solely and directly to Sharing Out (known as “Direct Donations” or “Donations”). ',
                  'Direct Donations', 'Donations'),
              space(context),
              sp('15.1.3 All Donations referred to in condition 15.1.1 are handled by Mezan Bank through their secure payments processing and will attract a payment handling fee determined by them.'),
              space(context),
              sp('15.1.4 When a Donation is made via the App, the transaction is final and not disputable unless unauthorised use of your payment card is proved. If you become aware of fraudulent use of your card, or if it is lost or stolen, you must notify your card provider in accordance with its reporting rules.'),
              space(context),
              sp('15.1.5 Before we can process a Donation, you must provide: (i) your name, address and email address; and (ii) details of the credit or debit card that you wish to use to fund the donation. This information is used to process your donation. It is your responsibility to ensure you have provided the correct information.'),
              space(context),
              sp('15.1.6 When you submit your payment details, you are providing them directly to our payment provider, Stripe, and your payment data will be collected and processed securely by them. You should make sure that you are aware of Mezan Banks’s terms and conditions, which are different from our own, to ensure that you are comfortable with how they will process your personal data before you make a Donation. You may find these on their website.'),
              space(context),
              sp('15.1.7 These Terms apply separately to each single Donation that you make and they do not form a contract allowing for future or successive transactions to be set up. By confirming on the App that you wish to make a donation you agree to be bound by these Terms for that Donation.'),
              space(context),
              sp('15.1.8 If you make an error in your Donation please contact us by email at info@sharingout.org within 5 calendar days and, subject to our review confirming the error, a full refund will be made to you.'),
              SliverToBoxAdapter(
                child: SizedBox(
                  height: height / 30,
                ),
              ),
              SliverToBoxAdapter(
                child: Text(
                  '15.2 DONATIONS TO SHARING OUT SHARING OUT',
                  style: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                    fontFamily: 'Comfortaa',
                  ),
                ),
              ),
              space(context),
              sp('15.2.1 Direct Donations comprise two elements: a donation to Sharing Out and a payment handling fee (which will be taken by Mezan Bank).'),
              space(context),
              sp('15.2.2 There is a donations link in the App and any Seller or Buyer can click on this link and select the option for a Donation to go to Sharing Out.'),
              space(context),
              sp('15.2.3 The payment handling fee will be determined by Mezan Bank as a percentage of the Donation and/or a fixed fee. More information about Mezan Banks’s fees can be found at there website.'),
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
                              "SECTION C: SELLER TERMS AND CONDITIONS",
                            ),
                            defaultStyle: TextStyle(
                              fontSize: 12,
                              color: Colors.black,
                              fontFamily: 'Comfortaa',
                            ),
                            textAlign: TextAlign.left,
                          ))),
                ),
              ),
              space(context),
              sp('If you are a Seller and wish to use the Seller Services, you may do so in accordance with the terms of this Section C. You are a Seller if you add Items to the Sharing Out platform, whether for payment or for free.'),
              SliverToBoxAdapter(
                child: SizedBox(
                  height: height / 30,
                ),
              ),
              SliverToBoxAdapter(
                child: Text(
                  'INTRODUCTION',
                  style: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                    fontFamily: 'Comfortaa',
                  ),
                ),
              ),
              space(context),
              sp('Upon registration as a User, in consideration of your compliance with these terms and conditions, Sharing Out will provide you with the Seller Services as described in this Section C below.'),
              SliverToBoxAdapter(
                child: SizedBox(
                  height: height / 30,
                ),
              ),
              SliverToBoxAdapter(
                child: Text(
                  '16. SELLER SERVICES',
                  style: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                    fontFamily: 'Comfortaa',
                  ),
                ),
              ),
              space(context),
              sp('16.1 Subject to condition 1.5 of Section A above, the Seller Services will comprise the following:'),
              space(context),
              sp('16.1.1 the facility to create a Profile page (including a photo), which can be accessed by the Buyers;'),
              space(context),
              sp('16.1.2 the ability to advertise Items available for Sale;'),
              space(context),
              sp('16.1.3 the ability to set a purchase price (“Price”) payable by the Buyer in respect of any Item;'),
              space(context),
              sp('16.1.4 the ability to nominate a Direct Donation;'),
              space(context),
              sp('16.1.5 the ability to specify when you are able to supply Items to Buyers and at what location and preferred times;'),
              space(context),
              sp('16.1.5 the ability to post reviews and/or submit feedback about Buyers; and'),
              space(context),
              sp('16.1.6 any other features and functionalities of the Seller Services provided by Sharing Out to you from time to time'),
              SliverToBoxAdapter(
                child: SizedBox(
                  height: height / 30,
                ),
              ),
              SliverToBoxAdapter(
                child: Text(
                  '17. YOUR ADDITIONAL OBLIGATIONS AS A SELLER',
                  style: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                    fontFamily: 'Comfortaa',
                  ),
                ),
              ),
              space(context),
              sp('17.1 By choosing to be a Seller and to advertise and supply your Items to Buyers through the App, further to the general obligations on you as a User under section A of these Terms, you agree that all information submitted by you, the supply of the Items, and any other information provided or comments made to Buyers through the App, must:'),
              space(context),
              sp('17.1.1 be accurate, correct and up-to-date;'),
              space(context),
              sp('17.1.2 be provided with all reasonable care and skill in a manner consistent with generally accepted standards in the industry in which you operate; if any;'),
              space(context),
              sp('17.1.3 not breach any applicable statutory or regulatory requirements, including following good hygiene practice and food allergen practice and, where applicable, food safety management procedures based on the standards set by the relevant food competent authority (such as Pakistan);'),
              space(context),
              sp('17.1.4 not commit an offence by adding for sale any controlled substance (including but not limited to alcohol, solvents, weapons or fireworks) for which you do not hold the relevant licence to do so;'),
              space(context),
              sp('17.1.5 not be misleading, deceptive or in any way contravene any and all applicable consumer, health and safety and e-commerce laws and regulations; '),
              space(context),
              sp('17.1.6 not be obscene, defamatory or be in the reasonable view of Sharing Out deemed to be offensive and/or inappropriate; and'),
              space(context),
              sp('17.1.7 not supply any age restricted goods.'),
              space(context),
              sp('17.2 In using the Seller Services you must:'),
              space(context),
              sp('17.2.1 at all times keep all information including without limitation, communication and correspondences between you and the Buyers, and all information relating to the transaction process secure and confidential;'),
              space(context),
              sp('17.2.2 ensure your use of the Seller Services is personal to you; and'),
              space(context),
              sp('17.2.3 immediately notify Sharing Out in the event you have any reason to believe or suspect that a Buyer has breached any of these Terms.'),
              space(context),
              sp('17.3 You further acknowledge and agree that Sharing Out may, at its sole discretion, immediately remove your Profile from the App where it reasonably considers that such Profile, any information you have uploaded or Items provided, no longer meet the standards that Sharing Out requires of its Sellers on the App, at its absolute discretion and upon written notice to you. '),
              space(context),
              sp('17.4 Failure by Sharing Out to exercise its rights under condition 17.3 should not be taken as acceptance by Sharing Out of any failure on your part to comply with these Terms.'),
              SliverToBoxAdapter(
                child: SizedBox(
                  height: height / 30,
                ),
              ),
              SliverToBoxAdapter(
                child: Text(
                  '18. ADDITIONAL EXCLUSION OF WARRANTIES',
                  style: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                    fontFamily: 'Comfortaa',
                  ),
                ),
              ),
              space(context),
              sp('18.1 You acknowledge and agree that Sharing Out only provides you with the facility to add and supply Items to Buyers by providing you with the Seller Services. Sharing Out does not warrant, represent or guarantee that you will find any Buyers to supply Food or non-food Items to or achieve any specific results whatsoever.'),
              space(context),
              sp('18.2 You acknowledge and agree that using the Platform through the App may require registration, licensing or approval as a food business with the relevant food authority. Sharing Out provides information in relation to this area on the App. However, you acknowledge that this is intended as information only and does not constitute advice of any nature. Therefore, it must not be relied on to assist you in making or refraining from making a decision or to assist you in deciding on a course of action. Your use and reliance on any information on the App shall be at your own risk and we shall not be liable whatsoever for any damages and loss which you may incur as a result of or in connection with your use and reliance of such information. You undertake to conduct your own research and ensure that you comply with the requirements applicable to you. Sharing Out shall not be liable to you for any failure by you to comply with any relevant laws and regulations that may apply to you in the use of the Platform through the App.'),
              space(context),
              sp('18.3 You further agree that Sharing Out does not vet or verify the identity of the Buyers posted on the App. Consequently, Sharing Out does not warrant or guarantee:'),
              space(context),
              sp('18.4 the completeness, correctness and accuracy of any Buyer’s Profile;'),
              space(context),
              sp('18.5 that any transactions made by Buyers are genuine; or'),
              space(context),
              sp('18.6 the identity of the Buyers using the App.'),
              space(context),
              sp('18.7 You further acknowledge that Sharing Out has no control of and therefore has no liability whatsoever in respect of the behaviour, response and quality of the Buyers on the App.'),
              space(context),
              sp('18.8 Sharing Out provides the Seller Services solely to connect Sellers, with Buyers who may be seeking to Purchase Items from you. You acknowledge and agree that you are solely responsible for all communication with, and any subsequent dealings with, Buyers. You, the Seller, hereby indemnify Sharing Out in full and on demand against all losses, damages, costs, claims and expenses that Sharing Out incurs (including but not limited to such losses and damages incurred by Sharing Out in respect of sickness, disease or death of any Buyer arising out of or in connection with your acts or omissions in the use of the Platform) arising out of or in connection with any of your dealings with, or Items provided to Buyers.'),
            ],
          ),
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
