/*
 * Copyright 2007 ETH Zurich
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 *
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 * http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and limitations under the License.
 */
package org.llrp.ltk.types;

import org.jdom.Content;
import org.jdom.Element;
import org.jdom.Text;


/**
 * Array of UnsignedShorts - length encoded with first 16 bits
 *
 * @author gasserb
 */
public class UnsignedShortArray extends LLRPType {
    private UnsignedShort[] shorts;

    /**
         * Creates a new UnsignedShortArray object.
         *
         * @param shorts
         */
    public UnsignedShortArray(UnsignedShort[] shorts) {
        this.shorts = shorts.clone();
    }

    /**
     * Creates a new UnsignedShortArray object from jdom element - used for xml decoding
     *
     * @param bitList
     */
    public UnsignedShortArray(Element element) {
        decodeXML(element);
    }

    /**
         * Creates a new UnsignedShortArray object.
         *
         * @param length
         */
    public UnsignedShortArray(Integer length) {
        shorts = new UnsignedShort[length];
    }

    /**
         * first 16 bits of LLRPBitlist must indicate number of entries that follow
         */
    public UnsignedShortArray(LLRPBitList bits) {
        decodeBinary(bits);
    }

    /**
         * Creates a new UnsignedShortArray object.
         */
    public UnsignedShortArray() {
        shorts = new UnsignedShort[0];
    }

    /**
     * first 16 bits of LLRPBitlist must indicate number of entries that follow
     *
     * @param list
     */
    public void decodeBinary(LLRPBitList list) {
        Integer length = new SignedInteger(list.subList(0, 16)).toInteger();
        shorts = new UnsignedShort[length];

        for (Integer i = 1; i <= length; i++) {
            shorts[i - 1] = new UnsignedShort(list.subList(
                        i * UnsignedShort.length(), UnsignedShort.length()));
        }
    }

    /**
     * encodes length before encoding containing values
     *
     * @return LLRPBitList
     */
    public LLRPBitList encodeBinary() {
        LLRPBitList result = new LLRPBitList();
        result.append(new UnsignedShort(shorts.length).encodeBinary());

        for (Integer i = 0; i < shorts.length; i++) {
            result.append(shorts[i].encodeBinary());
        }

        return result;
    }

    /**
     * compare each element
     *
     * @param other
     *
     * @return boolean
     */
    public boolean equals(LLRPType other) {
        UnsignedShortArray ba = (UnsignedShortArray) other;

        if (ba.length() != this.length()) {
            return false;
        }

        for (Integer i = 0; i < shorts.length; i++) {
            if (!ba.get(i).equals(this.get(i))) {
                return false;
            }
        }

        return true;
    }

    /**
     * get UnsignedShort at specified position
     *
     * @param i
     *
     * @return UnsignedShort
     */
    public UnsignedShort get(Integer i) {
        return shorts[i];
    }

    /**
     * lenght in bits
     *
     * @return Integer
     */
    public Integer getBitLength() {
        return shorts.length * UnsignedShort.length();
    }

    /**
     * length in bytes
     *
     * @return Integer
     */
    public Integer getByteLength() {
        return shorts.length * 2;
    }

    /**
     * length of BaseType not array - for array length call size()
     *
     * @return
     */
    public static Integer length() {
        return UnsignedShort.length();
    }

    /**
     * set UnsignedShort at given location
     *
     * @param i
     * @param b
     */
    public void set(Integer i, UnsignedShort b) {
        if ((i < 0) || (i > shorts.length)) {
            return;
        } else {
            shorts[i] = b;
        }
    }

    /**
     * number of elements in array
     *
     * @return
     */
    public Integer size() {
        return shorts.length;
    }

    @Override
    public Content encodeXML(String name) {
        String s = "";

        for (UnsignedShort b : shorts) {
            s += " ";
            s += b.toInteger().toString();
        }

        s = s.replaceFirst(" ", "");

        Element element = new Element(name);
        element.setContent(new Text(s));

        return element;
    }

    @Override
    public void decodeXML(Element element) {
        String text = element.getText();
        String[] strings = text.split(" ");
        shorts = new UnsignedShort[strings.length];

        for (int i = 0; i < strings.length; i++) {
            shorts[i] = new UnsignedShort(strings[i]);
        }
    }
}
