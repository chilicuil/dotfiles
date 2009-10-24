*acp.txt*       Automatically opens popup menu for completions.

        Copyright (c) 2007-2009 Takeshi NISHIDA

AutoComplPop                                              *autocomplpop* *acp*

INTRODUCTION                    |acp-introduction|
INSTALLATION                    |acp-installation|
USAGE                           |acp-usage|
COMMANDS                        |acp-commands|
OPTIONS                         |acp-options|
SPECIAL THANKS                  |acp-thanks|
CHANGELOG                       |acp-changelog|
ABOUT                           |acp-about|


==============================================================================
INTRODUCTION                                                *acp-introduction*

With this plugin, your vim comes to automatically opens popup menu for
completions when you enter characters or move the cursor in Insert mode. It
won't prevent you continuing entering characters.


==============================================================================
INSTALLATION                                                *acp-installation*

Put all files into your runtime directory. If you have the zip file, extract
it to your runtime directory.

You should place the files as follows:
>
        <your runtime directory>/plugin/acp.vim
        <your runtime directory>/doc/acp.txt
        ...
<
If you disgust to jumble up this plugin and other plugins in your runtime
directory, put the files into new directory and just add the directory path to
'runtimepath'. It's easy to uninstall the plugin.

And then update your help tags files to enable fuzzyfinder help. See
|add-local-help| for details.


==============================================================================
USAGE                                                              *acp-usage*

If this plugin has been installed, auto-popup is enabled at startup by
default.

Which completion method is used depends on the text before the cursor. The
default behavior is as follows:

        kind      filetype    text before a cursor ~
        Keyword   *           two keyword characters
        Filename  *           a filename character + a path separator 
                              + 0 or more filename character
        Omni      ruby        ".", "::" or non-word character + ":"
                              (|+ruby| required.)
        Omni      python      "." (|+python| required.)
        Omni      html/xhtml  "<", "</" or ("<" + non-">" characters + " ")
        Omni      css         (":", ";", "{", "^", "@", or "!")
                              + 0 or 1 space

This behavior is customizable.


==============================================================================
COMMANDS                                                        *acp-commands*

                                                                  *:AcpEnable*
:AcpEnable
        enables auto-popup.

                                                                 *:AcpDisable*
:AcpDisable
        disables auto-popup.

                                                                    *:AcpLock*
:AcpLock
        suspends auto-popup temporarily.

        For the purpose of avoiding interruption to another script, it is
        recommended to insert this command and |:AcpUnlock| than |:AcpDisable|
        and |:AcpEnable| .

                                                                  *:AcpUnlock*
:AcpUnlock
        resumes auto-popup suspended by |:AcpLock| .


==============================================================================
OPTIONS                                                          *acp-options*

                                                    *g:acp_enableAtStartup*  >
  let g:acp_enableAtStartup = 1
<
        If non-zero, auto-popup is enabled at startup.

                                                      *g:acp_mappingDriven*  >
  let g:acp_mappingDriven = 0
<
        If non-zero, auto-popup is triggered by key mappings instead of
        |CursorMovedI| event. This is useful to avoid auto-popup by moving
        cursor in Insert mode.

                                                   *g:acp_ignorecaseOption*  >
  let g:acp_ignorecaseOption = 1
<
        Value set to 'ignorecase' temporarily when auto-popup.

                                                     *g:acp_completeOption*  >
  let g:acp_completeOption = '.,w,b,k'
<
        Value set to 'complete' temporarily when auto-popup.

                                                 *g:acp_completeoptPreview*  >
  let g:acp_completeoptPreview = 0
<
        If non-zero, "preview" is added to 'completeopt' when auto-popup.

                                             *g:acp_behaviorUserDefinedFunction*  >
  let g:acp_behaviorUserDefinedFunction = ''
<
        Function for user-defined completion. If empty, this completion will
        be never attempted.

        See also:|complete-functions|

                                             *g:acp_behaviorUserDefinedPattern*  >
  let g:acp_behaviorUserDefinedPattern = '\k$'
<
        Pattern before a cursor, which are needed to attempt user-defined
        completion.

                                             *g:acp_behaviorKeywordCommand*  >
  let g:acp_behaviorKeywordCommand = "\<C-p>"
<
        Command for keyword completion. This option is usually set "\<C-n>" or
        "\<C-p>".

                                              *g:acp_behaviorKeywordLength*  >
  let g:acp_behaviorKeywordLength = 2
<
        Length of keyword characters before a cursor, which are needed to
        attempt keyword completion. If negative value, this completion will be
        never attempted.

                                                 *g:acp_behaviorFileLength*  >
  let g:acp_behaviorFileLength = 0
<
        Length of filename characters before a cursor, which are needed to
        attempt filename completion. If negative value, this completion will
        be never attempted.

                                       *g:acp_behaviorRubyOmniMethodLength*  >
  let g:acp_behaviorRubyOmniMethodLength = 0
<
        Length of keyword characters before a cursor, which are needed to
        attempt ruby omni-completion for methods. If negative value, this
        completion will be never attempted.

                                       *g:acp_behaviorRubyOmniSymbolLength*  >
  let g:acp_behaviorRubyOmniSymbolLength = 1
<
        Length of keyword characters before a cursor, which are needed to
        attempt ruby omni-completion for symbols. If negative value, this
        completion will be never attempted.

                                           *g:acp_behaviorPythonOmniLength*  >
  let g:acp_behaviorPythonOmniLength = 0
<
        Length of keyword characters before a cursor, which are needed to
        attempt python omni-completion. If negative value, this completion
        will be never attempted.

                                             *g:acp_behaviorHtmlOmniLength*  >
  let g:acp_behaviorHtmlOmniLength = 0
<
        Length of keyword characters before a cursor, which are needed to
        attempt HTML omni-completion. If negative value, this completion will
        be never attempted.

                                      *g:acp_behaviorCssOmniPropertyLength*  >
  let g:acp_behaviorCssOmniPropertyLength = 1
<
        Length of keyword characters before a cursor, which are needed to
        attempt CSS omni-completion for properties. If negative value, this
        completion will be never attempted.

                                         *g:acp_behaviorCssOmniValueLength*  >
  let g:acp_behaviorCssOmniValueLength = 0
<
        Length of keyword characters before a cursor, which are needed to
        attempt CSS omni-completion for values. If negative value, this
        completion will be never attempted.

                                                           *g:acp_behavior*  >
  let g:acp_behavior = {}
<
        This option is for advanced users. This setting overrides other
        behavior options. This is a |Dictionary|. Each key corresponds to a
        filetype. '*' is default. Each value is a list. These are attempted in
        sequence until completion item is found. Each element is a
        |Dictionary| which has following items:

        "command":
          Command to be fed to open popup menu for completions.

        "completefunc":
          'completefunc' will be set to this user-provided function during the
          completion. Only makes sense when "command" is "<C-x><C-u>".

        "pattern", "exclude":
          If a text before a cursor matches "pattern" and not "exclude", popup
          menu is opened.

        "repeat":
          If non-zero, the last completion is automatically repeated.


==============================================================================
SPECIAL THANKS                                                    *acp-thanks*

- Daniel Schierbeck
- Ingo Karkat


==============================================================================
CHANGELOG                                                      *acp-changelog*

2.8.1
  - Fixed a bug which inserted a selected match to the next line when
    auto-wrapping (enabled with 'formatoptions') was performed.

2.8
  - Added g:acp_behaviorUserDefinedFunction option and
    g:acp_behaviorUserDefinedPattern option for users who want to make custom
    completion auto-popup.
  - Fixed a bug that setting 'spell' on a new buffer made typing go crazy.

2.7
  - Changed naming conventions for filenames, functions, commands, and options 
    and thus renamed them.
  - Added g:acp_behaviorKeywordCommand option. If you prefer the previous
    behavior for keyword completion, set this option "\<C-n>".
  - Changed default value of g:acp_ignorecaseOption option.

  The following were done by Ingo Karkat:

  - ENH: Added support for setting a user-provided 'completefunc' during the
    completion, configurable via g:acp_behavior. 
  - BUG: When the configured completion is <C-p> or <C-x><C-p>, the command to
    restore the original text (in on_popup_post()) must be reverted, too. 
  - BUG: When using a custom completion function (<C-x><C-u>) that also uses
    an s:...() function name, the s:GetSidPrefix() function dynamically
    determines the wrong SID. Now calling s:DetermineSidPrefix() once during
    sourcing and caching the value in s:SID. 
  - BUG: Should not use custom defined <C-X><C-...> completion mappings. Now
    consistently using unmapped completion commands everywhere. (Beforehand,
    s:PopupFeeder.feed() used mappings via feedkeys(..., 'm'), but
    s:PopupFeeder.on_popup_post() did not due to its invocation via
    :map-expr.) 

2.6:
  - Improved the behavior of omni completion for HTML/XHTML.

2.5:
  - Added some options to customize behavior easily:
      g:AutoComplPop_BehaviorKeywordLength
      g:AutoComplPop_BehaviorFileLength
      g:AutoComplPop_BehaviorRubyOmniMethodLength
      g:AutoComplPop_BehaviorRubyOmniSymbolLength
      g:AutoComplPop_BehaviorPythonOmniLength
      g:AutoComplPop_BehaviorHtmlOmniLength
      g:AutoComplPop_BehaviorCssOmniPropertyLength
      g:AutoComplPop_BehaviorCssOmniValueLength

2.4:
  - Added g:AutoComplPop_MappingDriven option.

2.3.1:
  - Changed to set 'lazyredraw' while a popup menu is visible to avoid
    flickering.
  - Changed a behavior for CSS.
  - Added support for GetLatestVimScripts.

2.3:
  - Added a behavior for Python to support omni completion.
  - Added a behavior for CSS to support omni completion.

2.2:
  - Changed not to work when 'paste' option is set.
  - Fixed AutoComplPopEnable command and AutoComplPopDisable command to
    map/unmap "i" and "R".

2.1:
  - Fixed the problem caused by "." command in Normal mode.
  - Changed to map "i" and "R" to feed completion command after starting
    Insert mode.
  - Avoided the problem caused by Windows IME.

2.0:
  - Changed to use CursorMovedI event to feed a completion command instead of
    key mapping. Now the auto-popup is triggered by moving the cursor.
  - Changed to feed completion command after starting Insert mode.
  - Removed g:AutoComplPop_MapList option.

1.7:
  - Added behaviors for HTML/XHTML. Now supports the omni completion for
    HTML/XHTML.
  - Changed not to show expressions for CTRL-R =.
  - Changed not to set 'nolazyredraw' while a popup menu is visible.

1.6.1:
  - Changed not to trigger the filename completion by a text which has
    multi-byte characters.

1.6:
  - Redesigned g:AutoComplPop_Behavior option.
  - Changed default value of g:AutoComplPop_CompleteOption option.
  - Changed default value of g:AutoComplPop_MapList option.

1.5:
  - Implemented continuous-completion for the filename completion. And added
    new option to g:AutoComplPop_Behavior.

1.4:
  - Fixed the bug that the auto-popup was not suspended in fuzzyfinder.
  - Fixed the bug that an error has occurred with Ruby-omni-completion unless
    Ruby interface.

1.3:
  - Supported Ruby-omni-completion by default.
  - Supported filename completion by default.
  - Added g:AutoComplPop_Behavior option.
  - Added g:AutoComplPop_CompleteoptPreview option.
  - Removed g:AutoComplPop_MinLength option.
  - Removed g:AutoComplPop_MaxLength option.
  - Removed g:AutoComplPop_PopupCmd option.

1.2:
  - Fixed bugs related to 'completeopt'.

1.1:
  - Added g:AutoComplPop_IgnoreCaseOption option.
  - Added g:AutoComplPop_NotEnableAtStartup option.
  - Removed g:AutoComplPop_LoadAndEnable option.
1.0:
  - g:AutoComplPop_LoadAndEnable option for a startup activation is added.
  - AutoComplPopLock command and AutoComplPopUnlock command are added to
    suspend and resume.
  - 'completeopt' and 'complete' options are changed temporarily while
    completing by this script.

0.4:
  - The first match are selected when the popup menu is Opened. You can insert
    the first match with CTRL-Y.

0.3:
  - Fixed the problem that the original text is not restored if 'longest' is
    not set in 'completeopt'. Now the plugin works whether or not 'longest' is
    set in 'completeopt', and also 'menuone'.

0.2:
  - When completion matches are not found, insert CTRL-E to stop completion.
  - Clear the echo area.
  - Fixed the problem in case of dividing words by symbols, popup menu is
    not opened.

0.1:
  - First release.


==============================================================================
ABOUT                                   *acp-about* *acp-contact* *acp-author*

Author:  Takeshi NISHIDA <ns9tks@DELETE-ME.gmail.com>
Licence: MIT Licence
URL:     http://www.vim.org/scripts/script.php?script_id=1879
         http://bitbucket.org/ns9tks/vim-autocomplpop/

Bugs/Issues/Suggestions/Improvements ~

Please submit to http://bitbucket.org/ns9tks/vim-autocomplpop/issues/ .

==============================================================================
 vim:tw=78:ts=8:ft=help:norl:

