<?xml version="1.0" encoding="UTF-8" ?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" 
	xmlns:llrp="http://www.llrp.org/ltk/schema/core/encoding/binary/1.0"
  xmlns:h="http://www.w3.org/1999/xhtml">
  <xsl:output omit-xml-declaration='yes' method='text' indent='no'/>
  
  <xsl:template match="/llrp:llrpdef">
    /*
    ***************************************************************************
    *  Copyright 2007 Impinj, Inc.
    *
    *  Licensed under the Apache License, Version 2.0 (the "License");
    *  you may not use this file except in compliance with the License.
    *  You may obtain a copy of the License at
    *
    *      http://www.apache.org/licenses/LICENSE-2.0
    *
    *  Unless required by applicable law or agreed to in writing, software
    *  distributed under the License is distributed on an "AS IS" BASIS,
    *  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
    *  See the License for the specific language governing permissions and
    *  limitations under the License.
    *
    ***************************************************************************
    */


    /*
    ***************************************************************************
    *
    *  This code is generated by Impinj LLRP .Net generator. Modification is
    *  not recommended.
    *
    ***************************************************************************
    */

    /*
    ***************************************************************************
    * File Name:       LLRPParam.cs
    *
    * Version:         1.0
    * Author:          Impinj
    * Organization:    Impinj
    * Date:            Jan. 18, 2008
    *
    * Description:     This file contains LLRP parameter definitions
    ***************************************************************************
    */

    using System;
    using System.IO;
    using System.Text;
    using System.Collections;
    using System.ComponentModel;
    using System.Xml;
    using System.Xml.Serialization;
    using System.Xml.Schema;
    using System.Runtime.InteropServices;

    using LLRP.DataType;

    namespace LLRP
    {
    #region Custom Parameter Interface
    <xsl:for-each select ="llrp:parameterDefinition">
      <xsl:variable name="custom_param_name">
        <xsl:value-of select="@name"/>
      </xsl:variable>
      <xsl:for-each select="llrp:parameter">
        <xsl:if test="@type='Custom'">
    public interface I<xsl:copy-of select="$custom_param_name"/>_Custom_Param : ICustom_Parameter {}
      </xsl:if>
      </xsl:for-each>     
    </xsl:for-each>
    #endregion

    <!--This portion defines the choice parameters in the LLRP xml file-->
    <xsl:for-each select="llrp:choiceDefinition">
      ///<xsl:text disable-output-escaping="yes">&lt;</xsl:text>summary<xsl:text disable-output-escaping="yes">&gt;</xsl:text>
      ///Allowed types: <xsl:for-each select="parameter">PARAM_<xsl:value-of select="@type"/>,</xsl:for-each>
      ///<xsl:text disable-output-escaping="yes">&lt;</xsl:text>/summary<xsl:text disable-output-escaping="yes">&gt;</xsl:text>
      public class UNION_<xsl:value-of select="@name"/> : ParamArrayList{}
    </xsl:for-each>
    <xsl:for-each select="llrp:parameterDefinition">
      <xsl:if test="@name!='Custom'">
      <xsl:variable name="parameter_name">
        <xsl:value-of select="@name"/>
      </xsl:variable>
        /// <xsl:text disable-output-escaping="yes">&lt;</xsl:text>summary<xsl:text disable-output-escaping="yes">&gt;</xsl:text>
        /// <xsl:for-each select ="llrp:annotation/llrp:description/h:p"><xsl:value-of select="."/></xsl:for-each>
        /// <xsl:text disable-output-escaping="yes">&lt;</xsl:text>/summary<xsl:text disable-output-escaping="yes">&gt;</xsl:text>
      public class PARAM_<xsl:value-of select="@name"/> : Parameter
      {
      public PARAM_<xsl:value-of select="@name"/>()
      {
      typeID = <xsl:value-of select="@typeNum"/>;
      <xsl:if test="@typeNum &lt; 100">tvCoding = true;</xsl:if>
      }

      <xsl:for-each select="*">
        <xsl:if test="name()='field'">
          public <xsl:call-template name='DefineDataType'/><xsl:text> </xsl:text><xsl:value-of select="@name"/><xsl:call-template name='DefineDefaultValue'/>
          <xsl:call-template name="DefineDataLength"/>
        </xsl:if>
        <xsl:if test="name()='reserved'">
          private const UInt16 param_reserved_len<xsl:copy-of select="position()"/> = <xsl:value-of select="@bitCount"/>;
        </xsl:if>
        <xsl:if test="name()='parameter'">
          <xsl:choose>
            <xsl:when test="@type='Custom'">
          <xsl:choose>
          <xsl:when test="contains(@repeat, '0-N') or contains(@repeat, '1-N')">
          public readonly CustomParameterArrayList <xsl:call-template name='DefineParameterName'/> = new CustomParameterArrayList();
          public void AddCustomParameter(I<xsl:copy-of select='$parameter_name'/>_Custom_Param param)
          {          
          <xsl:call-template name='DefineParameterName'/>.Add(param);
          }
          private void AddCustomParameter(ICustom_Parameter param)
          {
          <xsl:call-template name='DefineParameterName'/>.Add(param);
          }
          
          </xsl:when>
          <xsl:otherwise>
          public readonly I<xsl:copy-of select='$parameter_name'/>_Custom_Param <xsl:call-template name='DefineParameterName'/>;
          </xsl:otherwise>
          </xsl:choose>
            </xsl:when>
            <xsl:otherwise>  
              <xsl:choose>
              <xsl:when test="contains(@repeat, '0-N') or contains(@repeat, '1-N')">
              public PARAM_<xsl:value-of select="@type"/>[] <xsl:call-template name='DefineParameterName'/>;
            </xsl:when>
            <xsl:otherwise>
              public PARAM_<xsl:value-of select="@type"/><xsl:text> </xsl:text><xsl:call-template name='DefineParameterName'/>;   
            </xsl:otherwise>            
          </xsl:choose>            
            </xsl:otherwise>
          </xsl:choose>
        </xsl:if>
        <xsl:if test="name()='choice'">
          <xsl:variable name="choiceParameterName">
            <xsl:call-template name='DefineParameterName'/>
          </xsl:variable>
          public UNION_<xsl:value-of select="@type"/><xsl:text> </xsl:text><xsl:call-template name='DefineParameterName'/> = new UNION_<xsl:value-of select="@type"/>();
        </xsl:if>
      </xsl:for-each>
      <xsl:call-template name="PARAMDecodeFromBitArray"/>
      <xsl:call-template name="PARAMToString"/>
      <xsl:call-template name="PARAMFromXmlNode"/>
      <xsl:call-template name="PARAMEncodeToBitArray"/>      
      }
      </xsl:if>
    </xsl:for-each>
    }
  </xsl:template>
  
  <xsl:include href="templates.xslt"/>
  
</xsl:stylesheet>